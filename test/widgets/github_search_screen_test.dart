import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/data/repositories/github_repository_impl.dart';
import 'package:github_explorer/features/github_search/presentation/screens/github_search_screen.dart';
import 'package:github_explorer/features/github_search/providers/github_providers.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubSearchRepository extends Mock implements GithubSearchRepository {}

void main() {
  late MockGithubSearchRepository mockRepository;

  setUp(() {
    mockRepository = MockGithubSearchRepository();
    when(() => mockRepository.getRecentSearches()).thenAnswer((_) async => []);
  });

  testWidgets('Renders professional Developer Discovery header, suggestions, and profile',
      (WidgetTester tester) async {
    // Set screen size to standard mobile viewport to ensure realistic layout
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          githubSearchRepositoryProvider.overrideWithValue(mockRepository),
        ],
        child: const MaterialApp(
          home: GithubSearchScreen(),
        ),
      ),
    );

    // Pump frames to let entrance animations finish without timing out
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Developer Discovery'), findsOneWidget);
    expect(find.text('GitHub Explorer'), findsOneWidget);
    expect(find.text('Popular:'), findsOneWidget);
    expect(find.text('@octocat'), findsWidgets);
    expect(find.text('Search Profile'), findsOneWidget);
    expect(find.text('The Octocat'), findsOneWidget);
    expect(find.text('Public Repositories'), findsOneWidget);
  });
}
