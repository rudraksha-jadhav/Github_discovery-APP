import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/features/bookmarks/presentation/screens/bookmarks_screen.dart';
import 'package:github_explorer/features/explore/presentation/screens/explore_screen.dart';
import 'package:github_explorer/features/settings/presentation/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Multi-Screen Smoke & Feature Widget Tests', () {
    testWidgets('ExploreScreen renders banner, maintainers, and landmark repos',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ExploreScreen(),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Discover Developers'), findsOneWidget);
      expect(find.text('Explore Top Talent'), findsOneWidget);
      expect(find.text('Featured Maintainers'), findsOneWidget);
      expect(find.text('Landmark Repositories'), findsOneWidget);
      expect(find.text('Linus Torvalds'), findsOneWidget);
      expect(find.text('Dan Abramov'), findsOneWidget);
    });

    testWidgets('BookmarksScreen renders segmented control and empty state',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: BookmarksScreen(),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Saved Bookmarks'), findsOneWidget);
      expect(find.textContaining('Developers'), findsOneWidget);
      expect(find.textContaining('Repositories'), findsOneWidget);
      expect(find.text('No saved developers'), findsOneWidget);

      // Tap on Repositories segment
      await tester.tap(find.textContaining('Repositories'));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('No saved repositories'), findsOneWidget);
    });

    testWidgets('SettingsScreen renders Appearance, API Rate Limit, and About sections',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SettingsScreen(),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('Dark Mode'), findsOneWidget);
      expect(find.text('API Rate Limit'), findsOneWidget);
      expect(find.text('Data & Storage'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
      expect(find.text('GitHub Explorer'), findsOneWidget);
    });
  });
}
