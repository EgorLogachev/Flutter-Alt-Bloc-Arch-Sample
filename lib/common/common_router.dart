import 'package:alt_bloc/alt_bloc.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/auth/auth_screen.dart';

class ScreenRouter with ErrorsRouter implements BaseRouter {
  ScreenRouter(this._routesMap);

  final Map<String, BlocRouter> _routesMap;

  @override
  Future<T?> onRoute<T>(BuildContext context, String? name, args) {
    return _routesMap.containsKey(name)
        ? _routesMap[name]!(context, name, args) as Future<T?>
        : super.onRoute(context, name, args);
  }
}

mixin ErrorsRouter implements BaseRouter {

  static const connectionErrorRoute = '/connection-error';
  static const unauthorizedErrorRoute = '/unauthorized-error';
  static const unexpectedErrorRoute = '/unexpected-error';

  static final _routesMapper = <String, BlocRouter>{
    connectionErrorRoute : (context, routeName, args) => showConnectionErrorDialog(context),
    unauthorizedErrorRoute : (context, routeName, args) => Navigator.of(context).pushNamed(AuthScreen.routeName, arguments: args),
    unexpectedErrorRoute : (context, routeName, args) => showUnexpectedErrorDialog(context),
  };

  @override
  Future<T?> onRoute<T>(BuildContext context, String? name, args) {
    if (!_routesMapper.containsKey(name) && isInDebugMode) {
      throw FlutterError('Handler for route with name: $name and arguments: $args wasn\'t defined in app');
    }
    return _routesMapper[name]!.call(context, name, args) as Future<T?>;
  }
}

Future showConnectionErrorDialog(BuildContext context) {
  return showDialog(context: context, builder: (_) {
    return AlertDialog(
      title: Text('No internet connection.'),
      content: Text('Probably some issues with your internet connection. Please, check and try again.'),
    );
  });
}

Future showUnexpectedErrorDialog(BuildContext context) {
  return showDialog(context: context, builder: (_) {
    return AlertDialog(
      title: Text('Oops!'),
      content: Text('Sorry for that, but something went wrong. We\'re working on it.'),
    );
  });
}

abstract class BaseRouter {
  Future<T?> onRoute<T>(BuildContext context, String? name, dynamic args);
}