import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/url_launcher_utils.dart';
import '../../../github_search/providers/github_providers.dart';
import '../../providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final rateLimitAsync = ref.watch(rateLimitStatusProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section: Appearance
          _buildSectionHeader(context, 'Appearance', LucideIcons.palette, isDark),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dark Mode',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isDark ? 'Dark theme enabled' : 'Light theme enabled',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: isDark,
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    ref.read(isDarkModeProvider.notifier).toggle();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section: GitHub API Rate Limit
          _buildSectionHeader(context, 'API Rate Limit', LucideIcons.gauge, isDark),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: rateLimitAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (err, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Unable to retrieve rate limit status',
                    style: TextStyle(color: AppColors.error, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => ref.refresh(rateLimitStatusProvider),
                    icon: const Icon(LucideIcons.refreshCw, size: 14),
                    label: const Text('Retry'),
                  ),
                ],
              ),
              data: (info) {
                final fraction = info.usageFraction;
                final progressColor = info.remaining > 20
                    ? AppColors.success
                    : (info.remaining > 5 ? Colors.amber.shade700 : AppColors.error);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${info.remaining} / ${info.limit} remaining',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.refreshCw, size: 16),
                          tooltip: 'Refresh rate limit status',
                          onPressed: () => ref.refresh(rateLimitStatusProvider),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: 1.0 - fraction,
                        backgroundColor: isDark
                            ? AppColors.darkSurfaceElevated
                            : AppColors.lightSurfaceElevated,
                        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Public REST API Quota',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                        Text(
                          'Resets in ~${info.minutesUntilReset} min',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // Section: Data & Storage
          _buildSectionHeader(context, 'Data & Storage', LucideIcons.database, isDark),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: ListTile(
              leading: Icon(LucideIcons.history, color: AppColors.primary),
              title: const Text(
                'Clear Search History',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              subtitle: Text(
                'Remove all cached recent search terms',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              trailing: const Icon(LucideIcons.chevronRight, size: 18),
              onTap: () => _showClearHistoryDialog(context, ref),
            ),
          ),

          const SizedBox(height: 24),

          // Section: About
          _buildSectionHeader(context, 'About', LucideIcons.info, isDark),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(LucideIcons.github, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'GitHub Explorer',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          'Version 2.0.0 (Aurora Edition)',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'A modern developer discovery and repository explorer built with Flutter, Riverpod, and the public GitHub REST API.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: () => UrlLauncherUtils.launchGithubUrl('https://github.com'),
                  icon: const Icon(LucideIcons.externalLink, size: 14),
                  label: const Text('Open GitHub.com'),
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
      ],
    );
  }

  void _showClearHistoryDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear search history?'),
        content: const Text(
          'This will remove all recent searches from your device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              final searchRepo = ref.read(githubSearchRepositoryProvider);
              await searchRepo.clearRecentSearches();
              ref.read(searchViewModelProvider.notifier).clearRecentSearches();
              if (ctx.mounted) Navigator.of(ctx).pop();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Search history cleared.')),
                );
              }
            },
            child: const Text('Clear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
