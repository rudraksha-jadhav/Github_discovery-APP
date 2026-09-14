import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/core/network/api_exception.dart';
import 'package:github_explorer/data/models/github_repository.dart';
import 'package:github_explorer/data/models/github_user.dart';
import 'package:github_explorer/data/repositories/github_repository_impl.dart';
import 'package:github_explorer/features/github_search/presentation/view_models/search_state.dart';
import 'package:github_explorer/features/github_search/providers/github_providers.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubSearchRepository extends Mock implements GithubSearchRepository {}

void main() {
  late MockGithubSearchRepository mockRepository;
  late ProviderContainer container;

  const testUser = GithubUser(
    login: 'octocat',
    name: 'The Octocat',
    avatarUrl: 'https://avatars.githubusercontent.com/u/583231?v=4',
    htmlUrl: 'https://github.com/octocat',
    bio: 'GitHub mascot',
    publicRepos: 8,
    followers: 20,
    following: 2,
  );

  const testRepo = GithubRepository(
    name: 'boysenberry-repo-1',
    fullName: 'octocat/boysenberry-repo-1',
    htmlUrl: 'https://github.com/octocat/boysenberry-repo-1',
    stargazersCount: 5,
    forksCount: 2,
    fork: false,
  );

  setUp(() {
    mockRepository = MockGithubSearchRepository();
    when(() => mockRepository.getRecentSearches()).thenAnswer((_) async => ['torvalds']);

    container = ProviderContainer(
      overrides: [
        githubSearchRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('SearchViewModel', () {
    test('initial state has recent searches loaded', () async {
      // Read provider to trigger build() and _loadRecentSearches()
      container.read(searchViewModelProvider);
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final state = container.read(searchViewModelProvider);
      expect(state.recentSearches, ['torvalds']);
    });

    test('sets error state when username is empty', () async {
      final viewModel = container.read(searchViewModelProvider.notifier);

      await viewModel.search('   ');

      final state = container.read(searchViewModelProvider);
      expect(state, isA<SearchState>());
      state.maybeWhen(
        error: (exception, searchedUsername, _) {
          expect(exception, isA<EmptyUsernameException>());
          expect(searchedUsername, '   ');
        },
        orElse: () => fail('Expected error state'),
      );
    });

    test('transitions to success state with user and repositories', () async {
      when(() => mockRepository.searchUser('octocat')).thenAnswer(
        (_) async => const GithubSearchData(
          user: testUser,
          repositories: [testRepo],
        ),
      );
      when(() => mockRepository.getRecentSearches()).thenAnswer(
        (_) async => ['octocat', 'torvalds'],
      );

      final viewModel = container.read(searchViewModelProvider.notifier);

      final future = viewModel.search('octocat');

      // Verify that while searching, loading state is active
      expect(container.read(searchViewModelProvider).isLoading, true);

      await future;

      final state = container.read(searchViewModelProvider);
      state.maybeWhen(
        success: (user, repos, searchedUser, recents) {
          expect(user.login, 'octocat');
          expect(repos.length, 1);
          expect(searchedUser, 'octocat');
          expect(recents, contains('octocat'));
        },
        orElse: () => fail('Expected success state'),
      );
    });

    test('transitions to error state when repository throws ApiException', () async {
      when(() => mockRepository.searchUser('unknown_user')).thenThrow(
        const ApiUserNotFoundException(),
      );

      final viewModel = container.read(searchViewModelProvider.notifier);

      await viewModel.search('unknown_user');

      final state = container.read(searchViewModelProvider);
      state.maybeWhen(
        error: (exception, searchedUsername, _) {
          expect(exception, isA<ApiUserNotFoundException>());
          expect(searchedUsername, 'unknown_user');
        },
        orElse: () => fail('Expected error state'),
      );
    });

    test('avoids duplicate search if same user is already loaded', () async {
      when(() => mockRepository.searchUser('octocat')).thenAnswer(
        (_) async => const GithubSearchData(
          user: testUser,
          repositories: [testRepo],
        ),
      );

      final viewModel = container.read(searchViewModelProvider.notifier);

      await viewModel.search('octocat');
      verify(() => mockRepository.searchUser('octocat')).called(1);

      // Search again without force
      await viewModel.search('octocat');
      verifyNever(() => mockRepository.searchUser('octocat'));
    });
  });
}
