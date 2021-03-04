import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/common/common_router.dart';
import 'package:archsampleapp/screens/contacts/contacts_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AuthRouter extends ScreenRouter {

  AuthRouter() : super(_routesMapper);

  static const contactsRoute = ContactsScreen.routeName;
  static const closeScreenRoute = '/closeScreen';
  static const closeAppRoute = '/closeAppRoute';

  static final _routesMapper = <String, BlocRouter>{
    contactsRoute : (context, routeName, args) {
      return Navigator.of(context).pushReplacementNamed(routeName, arguments: args);
    },
    closeScreenRoute : (context, routeName, args) {
      Navigator.of(context).pop(args);
      return null;
    },
    closeAppRoute : (context, routeName, args) {
      SystemNavigator.pop();
      return null;
    },
  };
}