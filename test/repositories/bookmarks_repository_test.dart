import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/data/models/bookmark_item.dart';
import 'package:github_explorer/data/repositories/bookmarks_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('BookmarksNotifier', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('can add, check, and remove bookmarks', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bookmarksProvider.notifier);

      final item = BookmarkItem(
        id: 'octocat',
        type: BookmarkType.user,
        title: 'octocat',
        subtitle: 'The Octocat',
        url: 'https://github.com/octocat',
        savedAt: DateTime.now(),
      );

      expect(notifier.isBookmarked('octocat', BookmarkType.user), isFalse);

      await notifier.addBookmark(item);
      expect(notifier.isBookmarked('octocat', BookmarkType.user), isTrue);
      expect(container.read(bookmarksProvider).length, equals(1));

      await notifier.removeBookmark('octocat', BookmarkType.user);
      expect(notifier.isBookmarked('octocat', BookmarkType.user), isFalse);
      expect(container.read(bookmarksProvider).isEmpty, isTrue);
    });

    test('can toggle and clear bookmarks', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bookmarksProvider.notifier);

      final repoItem = BookmarkItem(
        id: 'flutter/flutter',
        type: BookmarkType.repository,
        title: 'flutter/flutter',
        subtitle: 'Flutter Framework',
        url: 'https://github.com/flutter/flutter',
        savedAt: DateTime.now(),
      );

      await notifier.toggleBookmark(repoItem);
      expect(notifier.isBookmarked('flutter/flutter', BookmarkType.repository), isTrue);

      await notifier.toggleBookmark(repoItem);
      expect(notifier.isBookmarked('flutter/flutter', BookmarkType.repository), isFalse);

      await notifier.addBookmark(repoItem);
      await notifier.clearAll();
      expect(container.read(bookmarksProvider).isEmpty, isTrue);
    });
  });
}
