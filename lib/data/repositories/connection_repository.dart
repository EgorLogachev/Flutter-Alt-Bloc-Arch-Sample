import 'package:archsampleapp/data/api/connection_api.dart';

abstract class ConnectionRepository {

  factory ConnectionRepository(ConnectionApi api) = _ConnectionRepositoryImpl;

  Future<int> fetchSession();
}

class _ConnectionRepositoryImpl implements ConnectionRepository {

  _ConnectionRepositoryImpl(this.api);

  final ConnectionApi api;

  Future<int> fetchSession() async => api.fetchSession();
}
