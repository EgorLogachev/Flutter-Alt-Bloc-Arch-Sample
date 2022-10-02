import 'package:archsampleapp/data/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<String> signIn(String email, String password) =>
      repository.signIn(email, password);
}
