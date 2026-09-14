import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../data/repositories/github_repository_impl.dart';
import '../../providers/github_providers.dart';
import 'search_state.dart';

class SearchViewModel extends Notifier<SearchState> {
  GithubSearchRepository get _repository =>
      ref.read(githubSearchRepositoryProvider);

  @override
  SearchState build() {
    // Asynchronously load recent searches on initialization
    _loadRecentSearches();
    return const SearchState.initial();
  }

  Future<void> _loadRecentSearches() async {
    try {
      final recents = await _repository.getRecentSearches();
      state = state.copyWith(recentSearches: recents);
    } catch (_) {
      // Ignored if local storage read fails
    }
  }

  Future<void> search(String rawUsername, {bool force = false}) async {
    final username = rawUsername.trim();

    if (username.isEmpty) {
      state = SearchState.error(
        exception: const EmptyUsernameException(),
        searchedUsername: rawUsername,
        recentSearches: state.recentSearches,
      );
      return;
    }

    // Prevent duplicate request while currently loading
    if (state.isLoading) return;

    // Avoid duplicate request if existing data is already loaded for the same username
    final isAlreadyLoaded = state.maybeWhen(
      success: (_, __, searchedUser, ___) =>
          searchedUser.toLowerCase() == username.toLowerCase(),
      orElse: () => false,
    );
    if (isAlreadyLoaded && !force) return;

    final currentRecents = state.recentSearches;

    state = SearchState.loading(
      username: username,
      recentSearches: currentRecents,
    );

    try {
      final result = await _repository.searchUser(username);
      final updatedRecents = await _repository.getRecentSearches();

      state = SearchState.success(
        user: result.user,
        repositories: result.repositories,
        searchedUsername: username,
        recentSearches: updatedRecents,
      );
    } on ApiException catch (e) {
      state = SearchState.error(
        exception: e,
        searchedUsername: username,
        recentSearches: currentRecents,
      );
    } catch (e) {
      state = SearchState.error(
        exception: ApiUnexpectedException(message: e.toString()),
        searchedUsername: username,
        recentSearches: currentRecents,
      );
    }
  }

  Future<void> retry() async {
    final lastSearched = state.maybeWhen(
      loading: (username, _) => username,
      error: (_, searchedUsername, __) => searchedUsername,
      success: (_, __, searchedUsername, ___) => searchedUsername,
      orElse: () => null,
    );

    if (lastSearched != null && lastSearched.isNotEmpty) {
      await search(lastSearched, force: true);
    }
  }

  Future<void> removeRecentSearch(String username) async {
    await _repository.removeRecentSearch(username);
    final updated = await _repository.getRecentSearches();
    state = state.copyWith(recentSearches: updated);
  }

  Future<void> clearRecentSearches() async {
    await _repository.clearRecentSearches();
    state = state.copyWith(recentSearches: const []);
  }
}
