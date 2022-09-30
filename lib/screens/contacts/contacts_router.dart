import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/screens/contact_details/contact_details_screen.dart';
import 'package:flutter/widgets.dart';

import '../connection_router.dart';

class ContactsRouter extends ConnectionRouter {

  static const contactDetailsRoute = ContactDetailsRoute.name;

  static final _routesMapper = <String, BlocRouter>{
    contactDetailsRoute : (context, routeName, args) {
      return Navigator.of(context).pushNamed(routeName!, arguments: args);
    }
  };

  @override
  Future<T?> onRoute<T>(BuildContext context, String? name, args) {
    return _routesMapper.containsKey(name)
        ? _routesMapper[name]!(context, name, args) as Future<T?>
        : super.onRoute(context, name, args);
  }
}