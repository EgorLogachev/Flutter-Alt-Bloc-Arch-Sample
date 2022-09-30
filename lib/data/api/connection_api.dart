import 'dart:math';

import 'package:archsampleapp/data/mock_data_generator.dart';
import 'package:archsampleapp/data/network/network_errors.dart';
import 'package:archsampleapp/data/network/network_service.dart';

class ConnectionApi {

  ConnectionApi(this._networkService);

  final NetworkService _networkService;

  Future<int> fetchSession() {
    var result = MockDataGenerator([
      Option(Random().nextInt(100), weight: 10),
      Option(UnauthorizedError(401, "Token expired")),
      Option(ConnectionError()),
      Option(UnexpectedError(500, ""))
    ]).next();
    return Future.delayed(Duration(milliseconds: 500), () => result is Error ? throw result : result);
  }
}