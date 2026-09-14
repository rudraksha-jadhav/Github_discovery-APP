import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/url_launcher_utils.dart';
import '../../../../data/models/bookmark_item.dart';
import '../../../../data/models/github_repository.dart';
import '../../../../data/repositories/bookmarks_repository.dart';
import '../../../github_search/presentation/widgets/skeleton_loading_widget.dart';
import '../../providers/repository_providers.dart';

class RepositoryDetailsScreen extends ConsumerWidget {
  final String owner;
  final String repo;

  const RepositoryDetailsScreen({
    super.key,
    required this.owner,
    required this.repo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final coords = RepoCoordinates(owner: owner, name: repo);
    final repoDetailsAsync = ref.watch(repoDetailsProvider(coords));
    final repoId = '$owner/$repo'.toLowerCase();
    final isBookmarked = ref
        .watch(bookmarksProvider.notifier)
        .isBookmarked(repoId, BookmarkType.repository);

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
          repo,
          style: TextStyle(
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 17,
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
            tooltip: isBookmarked ? 'Remove bookmark' : 'Bookmark repository',
            onPressed: () {
              final item = BookmarkItem(
                id: repoId,
                type: BookmarkType.repository,
                title: '$owner/$repo',
                subtitle: 'GitHub Repository',
                avatarUrl: 'https://github.com/$owner.png',
                url: 'https://github.com/$owner/$repo',
                savedAt: DateTime.now(),
              );
              ref.read(bookmarksProvider.notifier).toggleBookmark(item);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isBookmarked
                        ? 'Removed $owner/$repo from bookmarks'
                        : 'Saved $owner/$repo to bookmarks',
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
            tooltip: 'Open on GitHub',
            onPressed: () =>
                UrlLauncherUtils.launchGithubUrl('https://github.com/$owner/$repo'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: repoDetailsAsync.when(
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
                  'Failed to load repository',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  err.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => ref.refresh(repoDetailsProvider(coords)),
                  icon: const Icon(LucideIcons.refreshCw, size: 18),
                  label: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
        data: (data) => _buildContent(context, data, isDark),
      ),
    );
  }

  Widget _buildContent(BuildContext context, RepoDetailsData data, bool isDark) {
    final repo = data.repository;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          _buildHeaderCard(context, repo, isDark),
          const SizedBox(height: 16),
          // Stats Row
          _buildStatsRow(repo, isDark),
          const SizedBox(height: 16),
          // Language Breakdown
          if (data.languages.isNotEmpty) ...[
            _buildLanguagesCard(context, data.languages, isDark),
            const SizedBox(height: 16),
          ],
          // README Section
          _buildReadmeCard(context, data.readme, isDark),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, GithubRepository repo, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Owner row
          InkWell(
            onTap: () => context.push('/profile/$owner'),
            borderRadius: BorderRadius.circular(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: 'https://github.com/$owner.png',
                    width: 28,
                    height: 28,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  owner,
                  style: TextStyle(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  LucideIcons.chevronRight,
                  size: 14,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Repo Name
          Text(
            repo.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          if (repo.description?.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(
              repo.description!,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
          if (repo.language != null && repo.language!.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
              ),
              child: Text(
                repo.language!,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsRow(GithubRepository repo, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            'Stars',
            repo.stargazersCount.toString(),
            LucideIcons.star,
            Colors.amber.shade600,
            isDark,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatItem(
            'Forks',
            repo.forksCount.toString(),
            LucideIcons.gitFork,
            AppColors.primary,
            isDark,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatItem(
            'Type',
            repo.fork ? 'Fork' : 'Public',
            LucideIcons.shield,
            AppColors.primary,
            isDark,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color iconColor,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
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
          Icon(icon, size: 20, color: iconColor),
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

  Widget _buildLanguagesCard(
      BuildContext context, Map<String, int> languages, bool isDark) {
    final totalBytes = languages.values.fold<int>(0, (sum, v) => sum + v);
    if (totalBytes == 0) return const SizedBox.shrink();

    final palette = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accentMint,
      Colors.amber.shade600,
      Colors.cyan,
      Colors.indigo,
    ];

    final entries = languages.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.code2, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'Languages',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Multi-segment progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 10,
              child: Row(
                children: entries.asMap().entries.map((item) {
                  final idx = item.key;
                  final entry = item.value;
                  final fraction = entry.value / totalBytes;
                  final color = palette[idx % palette.length];
                  return Expanded(
                    flex: (fraction * 1000).toInt().clamp(1, 1000),
                    child: Container(color: color),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Labels
          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: entries.asMap().entries.map((item) {
              final idx = item.key;
              final entry = item.value;
              final pct = ((entry.value / totalBytes) * 100).toStringAsFixed(1);
              final color = palette[idx % palette.length];
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${entry.key} ($pct%)',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReadmeCard(BuildContext context, String readme, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(LucideIcons.fileText, size: 18, color: AppColors.primary),
                const SizedBox(width: 8),
                const Text(
                  'README.md',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MarkdownBody(
              data: readme,
              selectable: true,
              onTapLink: (text, href, title) {
                if (href != null) {
                  UrlLauncherUtils.launchGithubUrl(href);
                }
              },
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                p: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
                h1: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                h2: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                h3: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                code: TextStyle(
                  backgroundColor: isDark
                      ? AppColors.darkSurfaceElevated
                      : AppColors.lightSurfaceElevated,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
                codeblockDecoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkSurfaceElevated
                      : AppColors.lightSurfaceElevated,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
