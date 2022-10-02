import 'package:archsampleapp/data/repositories/connection_repository.dart';

class ConnectionUseCase {

  final ConnectionRepository _repository;

  ConnectionUseCase(this._repository);

  Future<int> fetchSession() => _repository.fetchSession();
}