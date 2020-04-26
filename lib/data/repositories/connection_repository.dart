import 'package:archsampleapp/data/api/connection_api.dart';

class ConnectionRepository {

  ConnectionRepository(this.api);

  final ConnectionApi api;

  Future<int> fetchSession() async => api.fetchSession();
}