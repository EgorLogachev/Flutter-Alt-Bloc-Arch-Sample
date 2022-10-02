import 'package:dio/dio.dart';

class ResponseError extends NetworkError {
  final int statusCode;
  final dynamic responseData;
  final Map<String, List<String>>? responseHeaders;

  const ResponseError(
      this.statusCode,
      this.responseData, {
        this.responseHeaders,
        dynamic error,
        String? baseUrl,
        String? path,
      }) : super(
    error: error,
    baseUrl: baseUrl,
    path: path,
  );

  T parseResponse<T>(T Function(dynamic) onParse) {
    return onParse(responseData);
  }

  @override
  String toString() =>
      'ResponseError{statusCode: $statusCode, responseData: $responseData, responseHeaders: $responseHeaders, error: ${super.error}, baseUrl: ${super.baseUrl}, path: ${super.path}}';
}

class TimeoutError extends NetworkError {
  const TimeoutError({
    dynamic error,
    String? baseUrl,
    String? path,
  }) : super(
    error: error,
    baseUrl: baseUrl,
    path: path,
  );

  @override
  String toString() => 'TimeoutError{error: ${super.error}, baseUrl: ${super.baseUrl}, path: ${super.path}';
}

class NetworkError {
  final dynamic error;
  final String? baseUrl;
  final String? path;

  const NetworkError({this.error, this.baseUrl, this.path});

  factory NetworkError.create(DioError error) {
    final cause = error.error;
    final baseUrl = error.requestOptions.baseUrl;
    final path = error.requestOptions.path;
    if (error.type == DioErrorType.response) {
      final response = error.response!;
      return ResponseError(
        response.statusCode!,
        response.data,
        responseHeaders: response.headers.map,
        error: cause,
        baseUrl: baseUrl,
        path: path,
      );
    } else if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return TimeoutError(
        error: cause,
        baseUrl: baseUrl,
        path: path,
      );
    } else {
      return NetworkError(
        error: cause,
        baseUrl: baseUrl,
        path: path,
      );
    }
  }

  @override
  String toString() => 'NetworkError{error: $error, baseUrl: $baseUrl, path: $path}';
}

class ConnectionError extends NetworkError {}

class UnauthorizedError extends ResponseError {
  UnauthorizedError(super.statusCode, super.responseData);
}

class UnexpectedError extends ResponseError {
  UnexpectedError(super.statusCode, super.responseData);
}
