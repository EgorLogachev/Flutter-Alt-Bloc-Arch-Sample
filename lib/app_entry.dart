import 'package:archsampleapp/screens/auth/auth_screen.dart';
import 'package:archsampleapp/screens/contact_details/contact_details_screen.dart';
import 'package:archsampleapp/screens/contacts/contacts_screen.dart';
import 'package:archsampleapp/screens/session/session_screen.dart';
import 'package:dependency_provider/dependency_provider.dart';
import 'package:flutter/material.dart';

import 'dependencies.dart';

class AppEntry extends StatefulWidget {

  const AppEntry({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> with Dependencies {

  final _routesMap = <String, Route Function(DependenciesProvider, RouteSettings)>{
    AuthRoute.name: (dp, settings) => AuthRoute(dp.signInUseCase, settings),
    ContactsRoute.name: (dp, settings) => ContactsRoute(dp.contactsUseCase, settings),
    ContactDetailsRoute.name: (dp, settings) => ContactDetailsRoute(dp.contactDetailsUseCase, settings),
    SessionRoute.name: (dp, settings) => SessionRoute(settings),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sample Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AuthRoute.name,
      onGenerateRoute: (RouteSettings settings) {
        return _routesMap[settings.name]?.call(provider, settings) ??
            MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
            );
      },
    );
  }
}
