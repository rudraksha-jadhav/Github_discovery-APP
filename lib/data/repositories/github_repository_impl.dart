import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../models/github_repository.dart';
import '../models/github_user.dart';
import '../services/github_api_service.dart';

class GithubSearchData {
  final GithubUser user;
  final List<GithubRepository> repositories;

  const GithubSearchData({
    required this.user,
    required this.repositories,
  });
}

abstract class GithubSearchRepository {
  Future<GithubSearchData> searchUser(String username);
  Future<List<String>> getRecentSearches();
  Future<void> saveRecentSearch(String username);
  Future<void> removeRecentSearch(String username);
  Future<void> clearRecentSearches();
}

class GithubSearchRepositoryImpl implements GithubSearchRepository {
  final GithubApiService _apiService;
  final SharedPreferences? _prefs;

  GithubSearchRepositoryImpl({
    required GithubApiService apiService,
    SharedPreferences? prefs,
  })  : _apiService = apiService,
        _prefs = prefs;

  @override
  Future<GithubSearchData> searchUser(String username) async {
    final cleanUsername = username.trim();

    // Fetch user and repositories concurrently for optimal responsiveness
    final userFuture = _apiService.getUser(cleanUsername);
    final reposFuture = _apiService.getRepositories(cleanUsername);

    final results = await Future.wait([userFuture, reposFuture]);

    final user = results[0] as GithubUser;
    final repositories = results[1] as List<GithubRepository>;

    // Save to recent searches if SharedPreferences is available
    await saveRecentSearch(user.login);

    return GithubSearchData(
      user: user,
      repositories: repositories,
    );
  }

  @override
  Future<List<String>> getRecentSearches() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    return prefs.getStringList(AppConstants.recentSearchesKey) ?? [];
  }

  @override
  Future<void> saveRecentSearch(String username) async {
    try {
      final prefs = _prefs ?? await SharedPreferences.getInstance();
      final currentList = prefs.getStringList(AppConstants.recentSearchesKey) ?? [];
      final updatedList = [
        username,
        ...currentList.where((name) => name.toLowerCase() != username.toLowerCase()),
      ];

      if (updatedList.length > AppConstants.maxRecentSearches) {
        updatedList.removeRange(AppConstants.maxRecentSearches, updatedList.length);
      }

      await prefs.setStringList(AppConstants.recentSearchesKey, updatedList);
    } catch (_) {
      // Storage failure should never block UI or search
    }
  }

  @override
  Future<void> removeRecentSearch(String username) async {
    try {
      final prefs = _prefs ?? await SharedPreferences.getInstance();
      final currentList = prefs.getStringList(AppConstants.recentSearchesKey) ?? [];
      currentList.removeWhere((name) => name.toLowerCase() == username.toLowerCase());
      await prefs.setStringList(AppConstants.recentSearchesKey, currentList);
    } catch (_) {
      // Non-critical operation
    }
  }

  @override
  Future<void> clearRecentSearches() async {
    try {
      final prefs = _prefs ?? await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.recentSearchesKey);
    } catch (_) {
      // Non-critical operation
    }
  }
}
