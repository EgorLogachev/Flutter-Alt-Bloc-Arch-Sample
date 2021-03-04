import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/screens/contact_details/contact_details_screen.dart';
import 'package:flutter/widgets.dart';

import '../connection_router.dart';

class ContactsRouter extends ConnectionRouter {

  static const contactDetailsRoute = ContactDetailsScreen.routeName;

  static final _routesMapper = <String, BlocRouter>{
    contactDetailsRoute : (context, routeName, args) {
      return Navigator.of(context).pushNamed(routeName, arguments: args);
    }
  };

  @override
  Future onRoute(BuildContext context, String name, dynamic args) {
    return _routesMapper.containsKey(name) ? _routesMapper[name](context, name, args) : super.onRoute(context, name, args);
  }
}