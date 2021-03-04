
import 'package:archsampleapp/screens/connection/connection_screen.dart';
import 'package:archsampleapp/screens/contact_details/contact_details_screen.dart';
import 'package:archsampleapp/screens/contacts/contacts_screen.dart';
import 'package:flutter/material.dart';

import 'dependencies.dart';
import 'screens/auth/auth_screen.dart';

class SampleApp extends StatefulWidget {

  const SampleApp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SampleAddState();
}

class _SampleAddState extends State<SampleApp> with Dependencies {

  _SampleAddState() {
    _routes = <String, WidgetBuilder>{
      AuthScreen.routeName : AuthScreen.builder(authRepository),
      ContactsScreen.routeName : ContactsScreen.builder(contactsRepository, connectionRepository),
      ContactDetailsScreen.routeName : ContactDetailsScreen.builder(connectionRepository),
      ConnectionScreen.routeName : ConnectionScreen.builder(),
    };
  }

  Map<String, WidgetBuilder> _routes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sample Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AuthScreen.routeName,
      routes: _routes,
    );
  }

}

