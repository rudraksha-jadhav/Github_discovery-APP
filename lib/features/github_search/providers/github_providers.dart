import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/dio_client.dart';
import '../../../data/repositories/github_repository_impl.dart';
import '../../../data/services/github_api_service.dart';
import '../presentation/view_models/search_state.dart';
import '../presentation/view_models/search_view_model.dart';

/// Provider for shared preferences instance, can be overridden in tests.
final sharedPreferencesProvider = Provider<SharedPreferences?>((ref) {
  return null;
});

/// Provider for DioClient.
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

/// Provider for GithubApiService.
final githubApiServiceProvider = Provider<GithubApiService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GithubApiServiceImpl(dioClient: dioClient);
});

/// Provider for GithubSearchRepository.
final githubSearchRepositoryProvider = Provider<GithubSearchRepository>((ref) {
  final apiService = ref.watch(githubApiServiceProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  return GithubSearchRepositoryImpl(apiService: apiService, prefs: prefs);
});

/// SearchViewModel provider managing the search feature state.
final searchViewModelProvider =
    NotifierProvider<SearchViewModel, SearchState>(SearchViewModel.new);
