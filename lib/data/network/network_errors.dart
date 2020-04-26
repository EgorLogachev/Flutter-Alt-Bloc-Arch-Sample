import 'package:dio/dio.dart';

class NetworkError extends Error {
  NetworkError({this.statusCode,
    this.responseData,
    this.responseHeaders,
    this.baseUrl,
    this.path,
    this.message});

  factory NetworkError.create(DioError error) {
    final response = error.response;
    final request = error.request;
    return NetworkError(
        statusCode: response?.statusCode,
        responseHeaders: response?.headers,
        responseData: response?.data,
        baseUrl: request?.baseUrl,
        path: request?.path,
        message: error.message);
  }

  final int statusCode;
  final dynamic responseData;
  final Headers responseHeaders;
  final String baseUrl;
  final String path;
  final String message;

  String get url => baseUrl + path;

  @override
  String toString() {
    return 'NetworkError{statusCode: $statusCode, responseData: $responseData, responseHeaders: $responseHeaders, baseUrl: $baseUrl, path: $path, message: $message}';
  }
}

class ConnectionError extends NetworkError {}

class UnauthorizedError extends NetworkError {}

class UnexpectedError extends NetworkError {}

class BadCredentialsError extends NetworkError {}
