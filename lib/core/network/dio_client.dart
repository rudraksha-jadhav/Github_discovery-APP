import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

/// Configures and creates Dio instances for GitHub REST API calls.
class DioClient {
  final Dio _dio;

  DioClient({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConstants.githubApiBaseUrl,
                connectTimeout: AppConstants.connectTimeout,
                receiveTimeout: AppConstants.receiveTimeout,
                headers: {
                  'Accept': 'application/vnd.github+json',
                  'X-GitHub-Api-Version': '2022-11-28',
                },
              ),
            );

  Dio get dio => _dio;
}
