import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/api_exception.dart';
import '../../core/network/dio_client.dart';
import '../models/github_activity.dart';
import '../models/github_repository.dart';
import '../models/github_user.dart';
import '../models/rate_limit_info.dart';

abstract class GithubApiService {
  Future<GithubUser> getUser(String username);
  Future<List<GithubRepository>> getRepositories(String username);
  Future<GithubRepository> getRepository(String owner, String repo);
  Future<String> getReadme(String owner, String repo);
  Future<List<GithubActivity>> getUserEvents(String username);
  Future<Map<String, int>> getLanguages(String owner, String repo);
  Future<RateLimitInfo> getRateLimitStatus();
}

class GithubApiServiceImpl implements GithubApiService {
  final DioClient _dioClient;

  GithubApiServiceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<GithubUser> getUser(String username) async {
    final cleanUsername = username.trim();
    if (cleanUsername.isEmpty) {
      throw const EmptyUsernameException();
    }

    try {
      final response = await _dioClient.dio.get<Map<String, dynamic>>(
        '/users/$cleanUsername',
      );

      final data = response.data;
      if (data == null) {
        throw const ApiUnexpectedException(message: 'Received empty response from GitHub.');
      }

      return GithubUser.fromJson(data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiUnexpectedException(message: 'Failed to process user profile: $e');
    }
  }

  @override
  Future<List<GithubRepository>> getRepositories(String username) async {
    final cleanUsername = username.trim();
    if (cleanUsername.isEmpty) {
      throw const EmptyUsernameException();
    }

    try {
      final response = await _dioClient.dio.get<List<dynamic>>(
        '/users/$cleanUsername/repos',
        queryParameters: {
          'sort': 'updated',
          'per_page': AppConstants.repoLimit,
        },
      );

      final data = response.data;
      if (data == null) {
        return <GithubRepository>[];
      }

      return data
          .whereType<Map<String, dynamic>>()
          .map((repoJson) => GithubRepository.fromJson(repoJson))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiUnexpectedException(message: 'Failed to process repositories: $e');
    }
  }

  @override
  Future<GithubRepository> getRepository(String owner, String repo) async {
    final cleanOwner = owner.trim();
    final cleanRepo = repo.trim();

    try {
      final response = await _dioClient.dio.get<Map<String, dynamic>>(
        '/repos/$cleanOwner/$cleanRepo',
      );

      final data = response.data;
      if (data == null) {
        throw const ApiUnexpectedException(message: 'Repository not found.');
      }

      return GithubRepository.fromJson(data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiUnexpectedException(message: 'Failed to process repository: $e');
    }
  }

  @override
  Future<String> getReadme(String owner, String repo) async {
    final cleanOwner = owner.trim();
    final cleanRepo = repo.trim();

    try {
      final response = await _dioClient.dio.get<dynamic>(
        '/repos/$cleanOwner/$cleanRepo/readme',
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.raw+json',
          },
          responseType: ResponseType.plain,
        ),
      );

      final data = response.data;
      if (data == null || data.toString().isEmpty) {
        return '# $cleanRepo\n\nNo README available.';
      }
      return data.toString();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return '# $cleanRepo\n\nNo README.md found in this repository.';
      }
      throw ApiException.fromDioException(e);
    } catch (e) {
      return '# $cleanRepo\n\nUnable to load README: $e';
    }
  }

  @override
  Future<List<GithubActivity>> getUserEvents(String username) async {
    final cleanUsername = username.trim();
    if (cleanUsername.isEmpty) {
      return <GithubActivity>[];
    }

    try {
      final response = await _dioClient.dio.get<List<dynamic>>(
        '/users/$cleanUsername/events',
        queryParameters: {'per_page': 25},
      );

      final data = response.data;
      if (data == null) return <GithubActivity>[];

      return data
          .whereType<Map<String, dynamic>>()
          .map((item) => GithubActivity.fromJson(item))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiUnexpectedException(message: 'Failed to fetch user events: $e');
    }
  }

  @override
  Future<Map<String, int>> getLanguages(String owner, String repo) async {
    final cleanOwner = owner.trim();
    final cleanRepo = repo.trim();

    try {
      final response = await _dioClient.dio.get<Map<String, dynamic>>(
        '/repos/$cleanOwner/$cleanRepo/languages',
      );

      final data = response.data;
      if (data == null) return <String, int>{};

      return data.map((key, value) => MapEntry(key, (value as num).toInt()));
    } catch (_) {
      return <String, int>{};
    }
  }

  @override
  Future<RateLimitInfo> getRateLimitStatus() async {
    try {
      final response = await _dioClient.dio.get<Map<String, dynamic>>(
        '/rate_limit',
      );

      final data = response.data;
      if (data == null) {
        return RateLimitInfo(
          limit: 60,
          remaining: 60,
          used: 0,
          resetTime: DateTime.now().add(const Duration(hours: 1)),
        );
      }

      return RateLimitInfo.fromJson(data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiUnexpectedException(message: 'Failed to check rate limit: $e');
    }
  }
}
