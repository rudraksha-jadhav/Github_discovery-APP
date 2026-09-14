import 'package:dio/dio.dart';

/// Representation of API and network errors for user-facing messaging.
sealed class ApiException implements Exception {
  final String title;
  final String message;
  final int? statusCode;

  const ApiException({
    required this.title,
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => '$title: $message (code: $statusCode)';

  factory ApiException.fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const ApiTimeoutException();

      case DioExceptionType.connectionError:
        return const ApiNetworkException();

      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        final responseData = error.response?.data;
        String? apiMessage;
        if (responseData is Map<String, dynamic>) {
          apiMessage = responseData['message'] as String?;
        }

        if (status == 404) {
          return const ApiUserNotFoundException();
        } else if (status == 403 &&
            (apiMessage?.toLowerCase().contains('rate limit') == true ||
                error.response?.headers.value('x-ratelimit-remaining') == '0')) {
          return const ApiRateLimitException();
        } else if (status != null && status >= 500) {
          return ApiServerException(
            message: 'GitHub is currently experiencing issues. Please try again later.',
            statusCode: status,
          );
        }
        return ApiUnexpectedException(
          message: apiMessage ?? 'Unexpected response from GitHub servers.',
          statusCode: status,
        );

      case DioExceptionType.cancel:
        return const ApiRequestCancelledException();

      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const ApiNetworkException();
    }
  }
}

class ApiUserNotFoundException extends ApiException {
  const ApiUserNotFoundException()
      : super(
          title: 'User not found',
          message: "We couldn't find a GitHub profile with that username.",
          statusCode: 404,
        );
}

class ApiRateLimitException extends ApiException {
  const ApiRateLimitException()
      : super(
          title: 'Too many requests',
          message: "GitHub's API rate limit has been reached. Please try again later.",
          statusCode: 403,
        );
}

class ApiNetworkException extends ApiException {
  const ApiNetworkException()
      : super(
          title: 'Something went wrong',
          message: "GitHub isn't responding right now. Please check your connection and try again.",
        );
}

class ApiTimeoutException extends ApiException {
  const ApiTimeoutException()
      : super(
          title: 'Connection timed out',
          message: 'The connection to GitHub took too long. Please try again.',
        );
}

class ApiServerException extends ApiException {
  const ApiServerException({required super.message, super.statusCode})
      : super(
          title: 'Server error',
        );
}

class ApiUnexpectedException extends ApiException {
  const ApiUnexpectedException({required super.message, super.statusCode})
      : super(
          title: 'Something went wrong',
        );
}

class ApiRequestCancelledException extends ApiException {
  const ApiRequestCancelledException()
      : super(
          title: 'Request cancelled',
          message: 'The search request was cancelled.',
        );
}

class EmptyUsernameException extends ApiException {
  const EmptyUsernameException()
      : super(
          title: 'Username required',
          message: 'Please enter a GitHub username to search.',
        );
}
