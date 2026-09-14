import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final featuredDevs = [
      {
        'name': 'Linus Torvalds',
        'username': 'torvalds',
        'bio': 'Creator of Linux and Git',
        'tag': 'Systems',
        'avatar': 'https://github.com/torvalds.png',
      },
      {
        'name': 'Dan Abramov',
        'username': 'gaearon',
        'bio': 'Co-author of Redux and Create React App',
        'tag': 'React & JS',
        'avatar': 'https://github.com/gaearon.png',
      },
      {
        'name': 'Mitchell Hashimoto',
        'username': 'mitchellh',
        'bio': 'Founder of HashiCorp, creator of Vagrant & Terraform',
        'tag': 'Infrastructure',
        'avatar': 'https://github.com/mitchellh.png',
      },
      {
        'name': 'Anthony Fu',
        'username': 'antfu',
        'bio': 'Vue / Vite / Nuxt core team member',
        'tag': 'Open Source',
        'avatar': 'https://github.com/antfu.png',
      },
      {
        'name': 'Hillel Wayne',
        'username': 'hwayne',
        'bio': 'Formal methods, TLA+, software history',
        'tag': 'Research',
        'avatar': 'https://github.com/hwayne.png',
      },
    ];

    final featuredRepos = [
      {
        'owner': 'flutter',
        'name': 'flutter',
        'desc': 'Flutter makes it easy and fast to build beautiful apps for mobile and beyond',
        'stars': '168k',
        'lang': 'Dart',
      },
      {
        'owner': 'facebook',
        'name': 'react',
        'desc': 'The library for web and native user interfaces.',
        'stars': '230k',
        'lang': 'JavaScript',
      },
      {
        'owner': 'torvalds',
        'name': 'linux',
        'desc': 'Linux kernel source tree',
        'stars': '190k',
        'lang': 'C',
      },
      {
        'owner': 'golang',
        'name': 'go',
        'desc': 'The Go programming language',
        'stars': '125k',
        'lang': 'Go',
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Discover Developers',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.9),
                  AppColors.secondary.withValues(alpha: 0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Explore Top Talent',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Browse notable engineers, maintainers, and world-class repositories shaping open-source software.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Featured Engineers
          Text(
            'Featured Maintainers',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          ...featuredDevs.map((dev) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                leading: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: dev['avatar']!,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      dev['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Featured',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@${dev['username']}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      dev['bio']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(LucideIcons.chevronRight, size: 18),
                onTap: () => context.push('/profile/${dev['username']}'),
              ),
            );
          }),

          const SizedBox(height: 24),

          // Landmark Repositories
          Text(
            'Landmark Repositories',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          ...featuredRepos.map((repo) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  child: const Icon(LucideIcons.folderGit2, color: AppColors.primary, size: 20),
                ),
                title: Text(
                  '${repo['owner']}/${repo['name']}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: Text(
                  repo['desc']!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.star, size: 14, color: Colors.amber.shade600),
                    const SizedBox(width: 4),
                    Text(
                      repo['stars']!,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8),
                    const Icon(LucideIcons.chevronRight, size: 18),
                  ],
                ),
                onTap: () => context.push('/repo/${repo['owner']}/${repo['name']}'),
              ),
            );
          }),
        ],
      ),
    );
  }
}
