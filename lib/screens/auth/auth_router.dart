import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/common/common_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../contacts/contacts_screen.dart';

class AuthRouter extends ScreenRouter {

  AuthRouter() : super(_routesMapper);

  static const contactsRoute = ContactsRoute.name;
  static const closeScreenRoute = '/closeScreen';
  static const closeAppRoute = '/closeAppRoute';

  static final _routesMapper = <String, BlocRouter>{
    contactsRoute : (context, routeName, args) {
      return Navigator.of(context).pushReplacementNamed(routeName!, arguments: args);
    },
    closeScreenRoute : (context, routeName, args) async {
      Navigator.of(context).pop(args);
    },
    closeAppRoute : (context, routeName, args) async {
      SystemNavigator.pop();
    },
  };
}