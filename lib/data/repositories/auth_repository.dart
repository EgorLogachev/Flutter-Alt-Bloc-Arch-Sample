import 'package:archsampleapp/data/api/auth_api.dart';

abstract class AuthRepository {
  factory AuthRepository(AuthApi _api) = _AuthRepositoryImpl;

  Future<String> signIn(String email, String password);
}

class _AuthRepositoryImpl implements AuthRepository {
  _AuthRepositoryImpl(this._api);

  final AuthApi _api;

  Future<String> signIn(String email, String password) async =>
      _api.signIn(email, password);
}