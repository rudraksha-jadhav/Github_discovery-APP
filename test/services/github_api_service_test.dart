import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/core/network/api_exception.dart';
import 'package:github_explorer/core/network/dio_client.dart';
import 'package:github_explorer/data/services/github_api_service.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}
class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockDio mockDio;
  late MockDioClient mockDioClient;
  late GithubApiServiceImpl apiService;

  setUp(() {
    mockDio = MockDio();
    mockDioClient = MockDioClient();
    when(() => mockDioClient.dio).thenReturn(mockDio);
    apiService = GithubApiServiceImpl(dioClient: mockDioClient);
  });

  group('GithubApiService', () {
    test('rejects empty username with EmptyUsernameException', () async {
      expect(
        () => apiService.getUser('   '),
        throwsA(isA<EmptyUsernameException>()),
      );
      expect(
        () => apiService.getRepositories(''),
        throwsA(isA<EmptyUsernameException>()),
      );
    });

    test('returns GithubUser on successful API response (200)', () async {
      final userResponseData = {
        'login': 'octocat',
        'name': 'The Octocat',
        'avatar_url': 'https://avatars.githubusercontent.com/u/583231?v=4',
        'html_url': 'https://github.com/octocat',
        'bio': 'Developer mascot',
        'public_repos': 8,
        'followers': 20,
        'following': 2,
      };

      when(() => mockDio.get<Map<String, dynamic>>('/users/octocat')).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: userResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/users/octocat'),
        ),
      );

      final user = await apiService.getUser('octocat');

      expect(user.login, 'octocat');
      expect(user.name, 'The Octocat');
      expect(user.publicRepos, 8);
    });

    test('returns List<GithubRepository> on successful repos response (200)', () async {
      final reposResponseData = [
        {
          'name': 'boysenberry-repo-1',
          'full_name': 'octocat/boysenberry-repo-1',
          'html_url': 'https://github.com/octocat/boysenberry-repo-1',
          'description': 'Testing repo',
          'language': 'Dart',
          'stargazers_count': 42,
          'forks_count': 10,
          'fork': false,
        }
      ];

      when(() => mockDio.get<List<dynamic>>(
            '/users/octocat/repos',
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => Response<List<dynamic>>(
          data: reposResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/users/octocat/repos'),
        ),
      );

      final repos = await apiService.getRepositories('octocat');

      expect(repos.length, 1);
      expect(repos.first.name, 'boysenberry-repo-1');
      expect(repos.first.stargazersCount, 42);
    });

    test('throws ApiUserNotFoundException on 404 response', () async {
      when(() => mockDio.get<Map<String, dynamic>>('/users/nonexistentuser')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/users/nonexistentuser'),
          response: Response(
            statusCode: 404,
            data: {'message': 'Not Found'},
            requestOptions: RequestOptions(path: '/users/nonexistentuser'),
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(
        () => apiService.getUser('nonexistentuser'),
        throwsA(isA<ApiUserNotFoundException>()),
      );
    });

    test('throws ApiRateLimitException on 403 rate limit response', () async {
      when(() => mockDio.get<Map<String, dynamic>>('/users/octocat')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/users/octocat'),
          response: Response(
            statusCode: 403,
            data: {'message': 'API rate limit exceeded'},
            requestOptions: RequestOptions(path: '/users/octocat'),
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(
        () => apiService.getUser('octocat'),
        throwsA(isA<ApiRateLimitException>()),
      );
    });

    test('throws ApiNetworkException on connection error', () async {
      when(() => mockDio.get<Map<String, dynamic>>('/users/octocat')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/users/octocat'),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(
        () => apiService.getUser('octocat'),
        throwsA(isA<ApiNetworkException>()),
      );
    });

    test('throws ApiTimeoutException on connection timeout', () async {
      when(() => mockDio.get<Map<String, dynamic>>('/users/octocat')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/users/octocat'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(
        () => apiService.getUser('octocat'),
        throwsA(isA<ApiTimeoutException>()),
      );
    });
  });
}
