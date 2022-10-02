import 'package:archsampleapp/data/network/network_errors.dart';
import 'package:archsampleapp/data/network/network_service.dart';

import '../mock_data_generator.dart';
import 'auth_api_error.dart';

abstract class AuthApi {

  factory AuthApi(NetworkService networkService) = _MockedAuthApiImpl;

  Future<String> signIn(String email, String password);
}

class _MockedAuthApiImpl implements AuthApi {

  _MockedAuthApiImpl(this._networkService);

  final NetworkService _networkService;

  Future<String> signIn(String email, String password) async {
    /// Generator with random errors
    final result = MockDataGenerator([
      Option("success", weight: 10),
      Option(ConnectionError()),
      Option(BadCredentialsError(401, 'Bad Credentials')),
      Option(UnexpectedError(500, ''))
    ]).next();
    return Future.delayed(Duration(milliseconds: 500), () => result is Error ? throw result : result);
  }
}
