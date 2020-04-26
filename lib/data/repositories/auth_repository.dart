import 'package:archsampleapp/data/api/auth_api.dart';

class AuthRepository {

  AuthRepository(this._api);
  
  final AuthApi _api;

  Future<String> signIn(String email, String password) async => _api.signIn(email, password);
  
}