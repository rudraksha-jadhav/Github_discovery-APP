import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/github_repository.dart';
import '../../../../data/models/github_user.dart';
import '../../providers/github_providers.dart';
import '../view_models/search_state.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/profile_card_widget.dart';
import '../widgets/recent_searches_widget.dart';
import '../widgets/repository_card_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/skeleton_loading_widget.dart';

class GithubSearchScreen extends ConsumerStatefulWidget {
  const GithubSearchScreen({super.key});

  @override
  ConsumerState<GithubSearchScreen> createState() => _GithubSearchScreenState();
}

class _GithubSearchScreenState extends ConsumerState<GithubSearchScreen> {
  late final TextEditingController _searchController;
  bool _sortByStars = false;

  // Curated initial demo showcase for a vibrant out-of-the-box landing state
  static final GithubUser _defaultDemoUser = GithubUser(
    login: 'octocat',
    name: 'The Octocat',
    avatarUrl: 'https://avatars.githubusercontent.com/u/583231?v=4',
    htmlUrl: 'https://github.com/octocat',
    bio:
        'Building the future of software, one commit at a time. Mascot of GitHub and friend to all coders worldwide.',
    publicRepos: 8,
    followers: 20400,
    following: 9,
    location: 'San Francisco, CA',
    company: 'GitHub',
    createdAt: DateTime(2008, 1, 26),
    type: 'Staff',
  );

  static final List<GithubRepository> _defaultDemoRepos = [
    GithubRepository(
      name: 'Spoon-Knife',
      fullName: 'octocat/Spoon-Knife',
      htmlUrl: 'https://github.com/octocat/Spoon-Knife',
      description:
          'This repository is for demonstration of Git and GitHub workflows. Fork it, make changes, and open pull requests.',
      language: 'HTML',
      stargazersCount: 12400,
      forksCount: 142000,
      fork: false,
      updatedAt: DateTime(2024, 1, 1),
    ),
    GithubRepository(
      name: 'boysenberry-repo-1',
      fullName: 'octocat/boysenberry-repo-1',
      htmlUrl: 'https://github.com/octocat/boysenberry-repo-1',
      description:
          'Sample automated code delivery pipelines and continuous integration testing repository.',
      language: 'TypeScript',
      stargazersCount: 420,
      forksCount: 88,
      fork: false,
      updatedAt: DateTime(2024, 1, 1),
    ),
    GithubRepository(
      name: 'octo-slide-deck',
      fullName: 'octocat/octo-slide-deck',
      htmlUrl: 'https://github.com/octocat/octo-slide-deck',
      description:
          'Interactive keynote presentation slides rendered natively with modern web animation technologies.',
      language: 'JavaScript',
      stargazersCount: 1100,
      forksCount: 230,
      fork: false,
      updatedAt: DateTime(2024, 1, 1),
    ),
  ];

  static const List<String> _suggestedDevelopers = [
    'octocat',
    'torvalds',
    'flutter',
    'gaearon',
    'mitchellh',
    'antfu',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: 'octocat');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _triggerSearch(String username) {
    final clean = username.trim();
    if (clean.isEmpty) return;
    _searchController.text = clean;
    FocusScope.of(context).unfocus();
    ref.read(searchViewModelProvider.notifier).search(clean);
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchViewModelProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final primaryTextColor =
        isDark ? AppColors.darkPrimaryText : AppColors.primaryText;
    final secondaryTextColor =
        isDark ? AppColors.darkSecondaryText : AppColors.secondaryText;
    final purpleColor = isDark ? AppColors.darkPurple : const Color(0xFF5B4FE9);

    final isLoading = searchState.isLoading;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : const Color(0xFFF7F6FF),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Professional Top Bar
                    _buildTopBar(isDark, primaryTextColor, secondaryTextColor),

                    const SizedBox(height: 18),

                    // Search component card
                    SearchBarWidget(
                      controller: _searchController,
                      isLoading: isLoading,
                      onSearch: _triggerSearch,
                    ),

                    const SizedBox(height: 14),

                    // Suggested Developers Quick Chips
                    _buildSuggestedChips(isDark, purpleColor),

                    const SizedBox(height: 14),

                    // Recent searches chips (if available)
                    if (searchState.recentSearches.isNotEmpty) ...[
                      RecentSearchesWidget(
                        recentSearches: searchState.recentSearches,
                        onSelect: _triggerSearch,
                        onRemove: (username) {
                          ref
                              .read(searchViewModelProvider.notifier)
                              .removeRecentSearch(username);
                        },
                        onClearAll: () {
                          ref
                              .read(searchViewModelProvider.notifier)
                              .clearRecentSearches();
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Dynamic Main Content Driven Directly by Real State
                    _buildContent(
                      searchState,
                      isDark,
                      primaryTextColor,
                      secondaryTextColor,
                      purpleColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(
    bool isDark,
    Color primaryTextColor,
    Color secondaryTextColor,
  ) {
    return Row(
      children: [
        // App Brand Logo Badge
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF5B4FE9), Color(0xFF8175F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF5B4FE9).withValues(alpha: 0.25),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              LucideIcons.github,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // App Title & Tagline
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Developer Discovery',
                style: AppTextStyles.pageTitle(primaryTextColor).copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                'GitHub Explorer',
                style: AppTextStyles.caption(secondaryTextColor).copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Modern Theme Pill Toggle
        InkWell(
          onTap: () {
            ref.read(isDarkModeProvider.notifier).toggle();
          },
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF21262D) : const Color(0xFFECE9FE),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? const Color(0xFF30363D) : const Color(0xFFDCD6FE),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isDark ? LucideIcons.moon : LucideIcons.sun,
                  size: 14,
                  color: isDark ? const Color(0xFFA78BFA) : const Color(0xFF5B4FE9),
                ),
                const SizedBox(width: 5),
                Text(
                  isDark ? 'Dark' : 'Light',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? const Color(0xFFA78BFA) : const Color(0xFF5B4FE9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestedChips(bool isDark, Color purpleColor) {
    return Row(
      children: [
        Icon(
          LucideIcons.sparkles,
          size: 14,
          color: purpleColor,
        ),
        const SizedBox(width: 6),
        Text(
          'Popular:',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkSecondaryText : AppColors.secondaryText,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _suggestedDevelopers.map((dev) {
                return Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: InkWell(
                    onTap: () => _triggerSearch(dev),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkSurface
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : const Color(0xFFE4E0FF),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '@$dev',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.darkPrimaryText
                              : const Color(0xFF4338CA),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(
    SearchState searchState,
    bool isDark,
    Color primaryTextColor,
    Color secondaryTextColor,
    Color purpleColor,
  ) {
    return searchState.when(
      initial: (recentSearches) => _buildProfileAndRepos(
        user: _defaultDemoUser,
        repositories: _defaultDemoRepos,
        primaryTextColor: primaryTextColor,
        secondaryTextColor: secondaryTextColor,
        purpleColor: purpleColor,
        isDark: isDark,
      ),
      loading: (_, __) => const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: SkeletonLoadingWidget(),
      ),
      error: (exception, searchedUsername, _) => ErrorStateWidget(
        exception: exception,
        onRetry: () {
          if (searchedUsername.isNotEmpty) {
            _triggerSearch(searchedUsername);
          } else {
            ref.read(searchViewModelProvider.notifier).retry();
          }
        },
      ),
      success: (user, repositories, _, __) {
        if (repositories.isEmpty) {
          return Column(
            children: [
              ProfileCardWidget(user: user),
              const SizedBox(height: 20),
              EmptyStateWidget(onSelectSuggestion: _triggerSearch),
            ],
          );
        }

        return _buildProfileAndRepos(
          user: user,
          repositories: repositories,
          primaryTextColor: primaryTextColor,
          secondaryTextColor: secondaryTextColor,
          purpleColor: purpleColor,
          isDark: isDark,
        );
      },
    );
  }

  Widget _buildProfileAndRepos({
    required GithubUser user,
    required List<GithubRepository> repositories,
    required Color primaryTextColor,
    required Color secondaryTextColor,
    required Color purpleColor,
    required bool isDark,
  }) {
    final sortedRepos = [...repositories];
    if (_sortByStars) {
      sortedRepos.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Card
        ProfileCardWidget(user: user),

        const SizedBox(height: 24),

        // Repositories Header with Sort Toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Public Repositories',
                  style: AppTextStyles.sectionTitle(primaryTextColor).copyWith(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF21262D) : const Color(0xFFECE9FE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    repositories.length.toString(),
                    style: AppTextStyles.caption(purpleColor).copyWith(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            // Sort Toggle Pill
            GestureDetector(
              onTap: () => setState(() => _sortByStars = !_sortByStars),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : const Color(0xFFE4E0FF),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.arrowDownUp,
                      size: 13,
                      color: purpleColor,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _sortByStars ? 'Stars' : 'Latest',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: purpleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Repositories List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedRepos.length,
          itemBuilder: (context, index) {
            final repo = sortedRepos[index];
            return RepositoryCardWidget(
              repository: repo,
              index: index,
            );
          },
        ),
      ],
    );
  }
}
