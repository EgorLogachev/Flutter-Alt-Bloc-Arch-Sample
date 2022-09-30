import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import 'network_errors.dart';

///ToDo:
/// - think about http 2 adapter (https://github.com/flutterchina/dio/tree/master/plugins/http2_adapter)

class RequestMethod {
  static const post = 'POST';
  static const get = 'GET';
  static const put = 'PUT';
  static const delete = 'DELETE';
}

typedef OnParse<T> = FutureOr<T> Function(Response);

abstract class NetworkService {
  factory NetworkService({
    String baseUrl,
    int connectTimeout,
    int receiveTimeout,
    int sendTimeout,
    Iterable<Interceptor>? interceptors,
  }) = _NetworkServiceImpl;

  set baseUrl(String url);

  set proxyIp(String proxyIp);

  Future<T?> postRequest<T>(
      String path, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        dynamic data,
        Map<String, dynamic>? extra,
        OnParse<T>? onParse,
        bool retry,
      });

  Future<T?> getRequest<T>(
      String path, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? extra,
        OnParse<T>? onParse,
        bool retry,
      });

  Future deleteRequest(String path);

  Future<T?> putRequest<T>(
      String path, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        dynamic data,
        Map<String, dynamic>? extra,
        OnParse<T>? onParse,
        bool retry,
      });

  Future<T?> request<T>(
      String path,
      String method, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        dynamic data,
        Map<String, dynamic>? extra,
        OnParse<T>? onParse,
        bool retry,
      });
}

class _NetworkServiceImpl implements NetworkService {
  _NetworkServiceImpl({
    String baseUrl = '',
    int connectTimeout = defaultTimeout,
    int receiveTimeout = defaultTimeout,
    int sendTimeout = defaultTimeout,
    Iterable<Interceptor>? interceptors,
  }) : _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    ),
  )..interceptors.addAll([...?interceptors]) {
    _dio.interceptors.add(
      RetryInterceptor(dio: _dio, retryDelays: [for (int i = 1; i <= 3; i++) Duration(milliseconds: 500 * i)]),
    );
  }

  static const int defaultTimeout = 5000;

  final Dio _dio;

  @override
  Future<T?> postRequest<T>(
      String path, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        dynamic data,
        Map<String, dynamic>? extra,
        OnParse<T>? onParse,
        bool retry = false,
      }) async {
    return request(
      path,
      RequestMethod.post,
      queryParameters: queryParameters,
      data: data,
      onParse: onParse,
      headers: headers,
      extra: extra,
      retry: retry,
    );
  }

  @override
  Future<T?> getRequest<T>(
      String path, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? extra,
        OnParse<T>? onParse,
        bool retry = false,
      }) async {
    return request(
      path,
      RequestMethod.get,
      queryParameters: queryParameters,
      onParse: onParse,
      extra: extra,
      retry: retry,
      headers: headers,
    );
  }

  @override
  Future deleteRequest(
      String path, {
        bool retry = false,
      }) {
    return request(
      path,
      RequestMethod.delete,
      retry: retry,
    );
  }

  @override
  Future<T?> putRequest<T>(
      String path, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        dynamic data,
        Map<String, dynamic>? extra,
        OnParse<T>? onParse,
        bool retry = false,
      }) async {
    return request(
      path,
      RequestMethod.put,
      data: data,
      queryParameters: queryParameters,
      onParse: onParse,
      extra: extra,
      retry: retry,
    );
  }

  @override
  Future<T?> request<T>(
      String path,
      String method, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        dynamic data,
        Map<String, dynamic>? extra,
        OnParse<T>? onParse,
        bool retry = false,
      }) async {
    try {
      final options = Options()
        ..method = method
        ..headers = headers ?? <String, dynamic>{}
        ..extra = extra ?? <String, dynamic>{}
        ..disableRetry = !retry;
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return onParse == null ? response.data : onParse(response);
    } on DioError catch (e) {
      if (e.type != DioErrorType.cancel) {
        throw NetworkError.create(e);
      }
    }
    return null;
  }

  @override
  set baseUrl(String url) {
    final baseUrl = _dio.options.baseUrl;
    _dio.options.baseUrl = baseUrl.isEmpty
        ? url
        : throw StateError('Base URL has been already set up to $baseUrl. You\'re trying to reset the value.');
  }

  @override
  set proxyIp(String proxyIp) {
    _dio.httpClientAdapter = proxyIp.isEmpty
        ? DefaultHttpClientAdapter()
        : (DefaultHttpClientAdapter()
          ..onHttpClientCreate = (client) {
            return client
              ..findProxy = (_) {
                return 'PROXY $proxyIp:8888';
              }
              ..badCertificateCallback = (_, __, ___) => Platform.isAndroid;
          });
  }
}
