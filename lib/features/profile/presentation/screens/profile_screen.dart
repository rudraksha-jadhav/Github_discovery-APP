import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/url_launcher_utils.dart';
import '../../../../data/models/bookmark_item.dart';
import '../../../../data/models/github_activity.dart';
import '../../../../data/models/github_repository.dart';
import '../../../../data/models/github_user.dart';
import '../../../../data/repositories/bookmarks_repository.dart';
import '../../../github_search/presentation/widgets/skeleton_loading_widget.dart';
import '../../providers/profile_providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String username;

  const ProfileScreen({super.key, required this.username});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String _repoSearchQuery = '';
  String _selectedLanguage = 'All';
  String _sortBy = 'stars'; // 'stars', 'updated', 'forks'

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profileAsync = ref.watch(profileDetailsProvider(widget.username));
    final isBookmarked = ref
        .watch(bookmarksProvider.notifier)
        .isBookmarked(widget.username.toLowerCase(), BookmarkType.user);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            LucideIcons.arrowLeft,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.username,
          style: TextStyle(
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? LucideIcons.check : LucideIcons.bookmark,
              color: isBookmarked
                  ? AppColors.primary
                  : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
            ),
            tooltip: isBookmarked ? 'Remove bookmark' : 'Bookmark profile',
            onPressed: () {
              final item = BookmarkItem(
                id: widget.username.toLowerCase(),
                type: BookmarkType.user,
                title: widget.username,
                subtitle: 'GitHub Developer',
                avatarUrl: 'https://github.com/${widget.username}.png',
                url: 'https://github.com/${widget.username}',
                savedAt: DateTime.now(),
              );
              ref.read(bookmarksProvider.notifier).toggleBookmark(item);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isBookmarked
                        ? 'Removed @${widget.username} from bookmarks'
                        : 'Saved @${widget.username} to bookmarks',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              LucideIcons.externalLink,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              size: 20,
            ),
            tooltip: 'Open in GitHub',
            onPressed: () =>
                UrlLauncherUtils.launchGithubUrl('https://github.com/${widget.username}'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: profileAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(16.0),
          child: SkeletonLoadingWidget(),
        ),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.alertCircle, size: 54, color: AppColors.error),
                const SizedBox(height: 16),
                Text(
                  'Failed to load profile',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  err.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => ref.refresh(profileDetailsProvider(widget.username)),
                  icon: const Icon(LucideIcons.refreshCw, size: 18),
                  label: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
        data: (data) => NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: _buildProfileHeader(context, data.user, isDark),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 3,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    tabs: [
                      const Tab(text: 'Overview'),
                      Tab(text: 'Repositories (${data.repositories.length})'),
                      Tab(text: 'Activity (${data.activities.length})'),
                    ],
                  ),
                  isDark ? AppColors.darkSurface : AppColors.lightSurface,
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(context, data, isDark),
              _buildRepositoriesTab(context, data.repositories, isDark),
              _buildActivityTab(context, data.activities, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, GithubUser user, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.35), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user.avatarUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (c, u) => Container(
                      width: 80,
                      height: 80,
                      color: isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated,
                    ),
                    errorWidget: (c, u, e) => const Icon(LucideIcons.user, size: 40),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              // Name and handle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name?.isNotEmpty == true ? user.name! : user.login,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '@${user.login}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Badges
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _buildBadge(
                          user.type ?? 'User',
                          AppColors.primary,
                          LucideIcons.shield,
                          isDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (user.bio?.isNotEmpty == true) ...[
            const SizedBox(height: 14),
            Text(
              user.bio!,
              style: TextStyle(
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 16),
          // Metadata items
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              if (user.company?.isNotEmpty == true)
                _buildMetaItem(LucideIcons.building, user.company!, isDark),
              if (user.location?.isNotEmpty == true)
                _buildMetaItem(LucideIcons.mapPin, user.location!, isDark),
              if (user.blog?.isNotEmpty == true)
                InkWell(
                  onTap: () => UrlLauncherUtils.launchGithubUrl(user.blog!),
                  child: _buildMetaItem(LucideIcons.link, user.blog!, isDark, isLink: true),
                ),
            ],
          ),
          const SizedBox(height: 18),
          // Metrics Row
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Repositories',
                  user.publicRepos.toString(),
                  LucideIcons.bookOpen,
                  isDark,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricCard(
                  'Followers',
                  user.followers.toString(),
                  LucideIcons.users,
                  isDark,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricCard(
                  'Following',
                  user.following.toString(),
                  LucideIcons.userCheck,
                  isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color, IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(IconData icon, String text, bool isDark, {bool isLink = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: isLink ? AppColors.primary : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isLink
                ? AppColors.primary
                : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
            decoration: isLink ? TextDecoration.underline : TextDecoration.none,
            fontWeight: isLink ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(BuildContext context, ProfileDetailsData data, bool isDark) {
    final topRepos = [...data.repositories]
      ..sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
    final highlighted = topRepos.take(4).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Repositories',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => _tabController.animateTo(1),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (highlighted.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Text(
              'No repositories found',
              style: TextStyle(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          )
        else
          ...highlighted.map((repo) => _buildRepoCard(context, repo, isDark)),
        const SizedBox(height: 20),
        Text(
          'Recent Activity Snapshot',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        if (data.activities.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Text(
              'No recent public activity',
              style: TextStyle(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          )
        else
          ...data.activities.take(3).map((act) => _buildActivityItem(context, act, isDark)),
      ],
    );
  }

  Widget _buildRepositoriesTab(
      BuildContext context, List<GithubRepository> allRepos, bool isDark) {
    // Unique languages
    final languages = <String>{'All'};
    for (final r in allRepos) {
      if (r.language != null && r.language!.isNotEmpty) {
        languages.add(r.language!);
      }
    }

    // Filter
    var filtered = allRepos.where((repo) {
      final matchesSearch = _repoSearchQuery.isEmpty ||
          repo.name.toLowerCase().contains(_repoSearchQuery.toLowerCase()) ||
          (repo.description?.toLowerCase().contains(_repoSearchQuery.toLowerCase()) ??
              false);
      final matchesLang =
          _selectedLanguage == 'All' || repo.language == _selectedLanguage;
      return matchesSearch && matchesLang;
    }).toList();

    // Sort
    if (_sortBy == 'stars') {
      filtered.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
    } else if (_sortBy == 'forks') {
      filtered.sort((a, b) => b.forksCount.compareTo(a.forksCount));
    } else if (_sortBy == 'updated') {
      filtered.sort((a, b) {
        final aTime = a.updatedAt ?? DateTime(1970);
        final bTime = b.updatedAt ?? DateTime(1970);
        return bTime.compareTo(aTime);
      });
    }

    return Column(
      children: [
        // Controls (search + sort + lang)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          child: Column(
            children: [
              TextField(
                onChanged: (val) => setState(() => _repoSearchQuery = val),
                decoration: InputDecoration(
                  hintText: 'Search repositories...',
                  prefixIcon: const Icon(LucideIcons.search, size: 18),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: languages.map((lang) {
                          final isSelected = _selectedLanguage == lang;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: ChoiceChip(
                              label: Text(lang, style: const TextStyle(fontSize: 12)),
                              selected: isSelected,
                              onSelected: (_) => setState(() => _selectedLanguage = lang),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _sortBy,
                    underline: const SizedBox.shrink(),
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'stars', child: Text('Stars')),
                      DropdownMenuItem(value: 'updated', child: Text('Updated')),
                      DropdownMenuItem(value: 'forks', child: Text('Forks')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _sortBy = val);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        // Repo list
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Text(
                    'No matching repositories found.',
                    style: TextStyle(
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return _buildRepoCard(context, filtered[index], isDark);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildActivityTab(
      BuildContext context, List<GithubActivity> activities, bool isDark) {
    if (activities.isEmpty) {
      return Center(
        child: Text(
          'No public activities found.',
          style: TextStyle(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return _buildActivityItem(context, activities[index], isDark);
      },
    );
  }

  Widget _buildRepoCard(BuildContext context, GithubRepository repo, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          final owner = repo.fullName.contains('/')
              ? repo.fullName.split('/').first
              : widget.username;
          context.push('/repo/$owner/${repo.name}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.gitFork, size: 16, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      repo.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      repo.fork ? 'Fork' : 'Public',
                      style: TextStyle(
                        fontSize: 10,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (repo.description?.isNotEmpty == true) ...[
                const SizedBox(height: 6),
                Text(
                  repo.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  if (repo.language != null) ...[
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      repo.language!,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(width: 14),
                  ],
                  Icon(
                    LucideIcons.star,
                    size: 13,
                    color: Colors.amber.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    repo.stargazersCount.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Icon(
                    LucideIcons.gitFork,
                    size: 13,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    repo.forksCount.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    LucideIcons.chevronRight,
                    size: 16,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, GithubActivity act, bool isDark) {
    IconData icon;
    Color iconColor;

    switch (act.type) {
      case 'PushEvent':
        icon = LucideIcons.gitCommit;
        iconColor = AppColors.success;
        break;
      case 'WatchEvent':
        icon = LucideIcons.star;
        iconColor = Colors.amber.shade600;
        break;
      case 'ForkEvent':
        icon = LucideIcons.gitFork;
        iconColor = AppColors.secondary;
        break;
      case 'IssuesEvent':
        icon = LucideIcons.alertCircle;
        iconColor = Colors.orange;
        break;
      case 'PullRequestEvent':
        icon = LucideIcons.gitPullRequest;
        iconColor = AppColors.primary;
        break;
      default:
        icon = LucideIcons.activity;
        iconColor = AppColors.primary;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  act.actionTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  act.repoName,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (act.payloadDesc?.isNotEmpty == true) ...[
                  const SizedBox(height: 4),
                  Text(
                    act.payloadDesc!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, this._backgroundColor);

  final TabBar _tabBar;
  final Color _backgroundColor;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: _backgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
