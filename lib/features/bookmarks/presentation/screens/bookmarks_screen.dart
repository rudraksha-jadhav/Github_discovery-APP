import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/bookmark_item.dart';
import '../../../../data/repositories/bookmarks_repository.dart';

class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({super.key});

  @override
  ConsumerState<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends ConsumerState<BookmarksScreen> {
  int _selectedTabIndex = 0; // 0: Developers, 1: Repositories

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bookmarks = ref.watch(bookmarksProvider);

    final userBookmarks =
        bookmarks.where((b) => b.type == BookmarkType.user).toList();
    final repoBookmarks =
        bookmarks.where((b) => b.type == BookmarkType.repository).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Saved Bookmarks',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          if (bookmarks.isNotEmpty)
            IconButton(
              icon: const Icon(LucideIcons.trash2, size: 20),
              tooltip: 'Clear all bookmarks',
              onPressed: () => _showClearConfirmationDialog(context),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Segmented Control
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSegmentButton(
                      'Developers (${userBookmarks.length})',
                      0,
                      isDark,
                    ),
                  ),
                  Expanded(
                    child: _buildSegmentButton(
                      'Repositories (${repoBookmarks.length})',
                      1,
                      isDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildList(userBookmarks, BookmarkType.user, isDark)
                : _buildList(repoBookmarks, BookmarkType.repository, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String label, int index, bool isDark) {
    final isSelected = _selectedTabIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? Colors.white
                : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildList(
      List<BookmarkItem> items, BookmarkType type, bool isDark) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  type == BookmarkType.user ? LucideIcons.users : LucideIcons.bookmark,
                  size: 36,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                type == BookmarkType.user
                    ? 'No saved developers'
                    : 'No saved repositories',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                type == BookmarkType.user
                    ? 'Search for GitHub developers and tap the bookmark icon to save them for quick access.'
                    : 'Bookmark interesting open-source repositories to inspect and follow later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key('${item.type.name}_${item.id}'),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(LucideIcons.trash2, color: Colors.white),
          ),
          onDismissed: (_) {
            ref.read(bookmarksProvider.notifier).removeBookmark(item.id, item.type);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Removed ${item.title}'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Container(
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
              leading: item.avatarUrl != null
                  ? ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: item.avatarUrl!,
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => CircleAvatar(
                          backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                          child: Icon(
                            item.type == BookmarkType.user
                                ? LucideIcons.user
                                : LucideIcons.folderGit2,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                      child: Icon(
                        item.type == BookmarkType.user
                            ? LucideIcons.user
                            : LucideIcons.folderGit2,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
              title: Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                item.subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  LucideIcons.trash2,
                  size: 18,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
                onPressed: () {
                  ref.read(bookmarksProvider.notifier).removeBookmark(item.id, item.type);
                },
              ),
              onTap: () {
                if (item.type == BookmarkType.user) {
                  context.push('/profile/${item.title}');
                } else {
                  final parts = item.title.split('/');
                  if (parts.length >= 2) {
                    context.push('/repo/${parts[0]}/${parts[1]}');
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _showClearConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear all bookmarks?'),
        content: const Text(
          'This will permanently remove all your saved developers and repositories.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              ref.read(bookmarksProvider.notifier).clearAll();
              Navigator.of(ctx).pop();
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
