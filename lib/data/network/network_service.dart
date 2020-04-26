import 'package:dio/dio.dart';

import 'network_errors.dart';

class NetworkService {

  NetworkService(String baseUrl, {int connectionTimeout, int receiveTimeout, List<Interceptor> interceptors}) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: connectionTimeout, receiveTimeout: receiveTimeout));
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  Dio _dio;

  Future<T> postRequest<T>(String path, {dynamic data, Function(Response<dynamic>) onParse}) async {
    return createRequest(path, RequestMethod.POST, data: data, onParse: onParse);
  }

  Future<T> getRequest<T>(String path,
      {Map<String, dynamic> queryParameters, Function(Response<dynamic>) onParse}) async {
    return createRequest(path, RequestMethod.GET, queryParameters: queryParameters, onParse: onParse);
  }

  Future<T> putRequest<T>(String path, {dynamic data, Function(Response<dynamic>) onParse}) async {
    return createRequest(path, RequestMethod.PUT, data: data, onParse: onParse);
  }

  Future<T> createRequest<T>(String path, String method,
      {dynamic data, Map<String, dynamic> queryParameters, Function(Response<dynamic>) onParse}) async {
    try {
      final options = Options()..method = method;
      final response = await _dio.request(path, data: data, queryParameters: queryParameters, options: options);
      print(response.data);
      return onParse != null ? await onParse(response) : null;
    } on DioError catch (e) {
      return Future.error(NetworkError.create(e));
    } catch (e) {
      return Future.error(e);
    }
  }
}

class RequestMethod {
  static const POST = 'POST';
  static const GET = 'GET';
  static const PUT = 'PUT';
}