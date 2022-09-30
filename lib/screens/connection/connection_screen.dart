import 'package:archsampleapp/screens/connection_bloc.dart' as bloc;
import 'package:flutter/material.dart';

import 'connection_layout.dart';

class ConnectionRoute extends MaterialPageRoute {

  static const name = '/connection';

  ConnectionRoute(RouteSettings settings)
      : super(
          builder: (_) => _ConnectionScreenWidget(),
          settings: settings,
        );
}

class _ConnectionScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //todo change it
    final connectionState = ModalRoute.of(context)?.settings.arguments as bloc.ConnectionState;
    final isCall = connectionState is bloc.CallConnectionState;
    return ConnectionLayout(isCall ? Icons.call : Icons.chat,
        isCall ? 'Call to ${connectionState.contact.name}' : 'Chat request to ${connectionState.contact.name}');
  }
}
