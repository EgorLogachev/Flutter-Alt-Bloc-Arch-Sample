import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/common/common_router.dart';
import 'package:archsampleapp/screens/session/session_screen.dart';
import 'package:flutter/widgets.dart';


class ConnectionRouter extends ScreenRouter {

  ConnectionRouter() : super(_routesMapper);

  static const sessionRoute = SessionRoute.name;

  static final _routesMapper = <String, BlocRouter>{
    sessionRoute : (context, routeName, args) {
      return Navigator.of(context).pushNamed(routeName!, arguments: args);
    },
  };
}