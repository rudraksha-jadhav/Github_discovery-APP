import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../data/models/github_repository.dart';
import '../../../../data/models/github_user.dart';

part 'search_state.freezed.dart';

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState.initial({
    @Default([]) List<String> recentSearches,
  }) = _Initial;

  const factory SearchState.loading({
    required String username,
    @Default([]) List<String> recentSearches,
  }) = _Loading;

  const factory SearchState.success({
    required GithubUser user,
    required List<GithubRepository> repositories,
    required String searchedUsername,
    @Default([]) List<String> recentSearches,
  }) = _Success;

  const factory SearchState.error({
    required ApiException exception,
    required String searchedUsername,
    @Default([]) List<String> recentSearches,
  }) = _Error;
}

extension SearchStateX on SearchState {
  bool get isLoading =>
      maybeWhen(loading: (_, __) => true, orElse: () => false);
}
