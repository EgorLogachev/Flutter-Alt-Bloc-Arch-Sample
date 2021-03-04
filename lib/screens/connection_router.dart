import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/screens/connection/connection_screen.dart';
import 'package:flutter/widgets.dart';

import '../common/common_router.dart';

class ConnectionRouter extends ScreenRouter {

  ConnectionRouter() : super(_routesMapper);

  static const connectionRoute = ConnectionScreen.routeName;

  static final _routesMapper = <String, BlocRouter>{
    connectionRoute : (context, routeName, args) {
      return Navigator.of(context).pushNamed(routeName, arguments: args);
    },
  };
}