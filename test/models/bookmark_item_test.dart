import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/data/models/bookmark_item.dart';

void main() {
  group('BookmarkItem', () {
    test('serializes and deserializes user bookmark correctly', () {
      final item = BookmarkItem(
        id: 'octocat',
        type: BookmarkType.user,
        title: 'The Octocat',
        subtitle: 'GitHub Mascot',
        avatarUrl: 'https://avatars.githubusercontent.com/u/583231?v=4',
        url: 'https://github.com/octocat',
        savedAt: DateTime(2024, 1, 1),
      );

      final jsonString = item.toJson();
      final parsed = BookmarkItem.fromJson(jsonString);

      expect(parsed.id, equals('octocat'));
      expect(parsed.type, equals(BookmarkType.user));
      expect(parsed.title, equals('The Octocat'));
      expect(parsed.avatarUrl, contains('583231'));
      expect(parsed == item, isTrue);
    });

    test('serializes and deserializes repository bookmark correctly', () {
      final item = BookmarkItem(
        id: 'flutter/flutter',
        type: BookmarkType.repository,
        title: 'flutter/flutter',
        subtitle: 'Google UI Toolkit',
        url: 'https://github.com/flutter/flutter',
        savedAt: DateTime(2024, 1, 1),
      );

      final jsonString = item.toJson();
      final parsed = BookmarkItem.fromJson(jsonString);

      expect(parsed.id, equals('flutter/flutter'));
      expect(parsed.type, equals(BookmarkType.repository));
      expect(parsed.title, equals('flutter/flutter'));
      expect(parsed == item, isTrue);
    });
  });
}
