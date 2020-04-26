import 'package:archsampleapp/screens/connection_bloc.dart' as bloc;
import 'package:flutter/material.dart';

import 'connection_layout.dart';

class ConnectionScreen {

  static const routeName = '/connection';

  static WidgetBuilder builder() => (context) {
    final bloc.ConnectionState connectionState = ModalRoute.of(context).settings.arguments;
    final isCall = connectionState is bloc.CallConnectionState;
    return ConnectionLayout(isCall ? Icons.call : Icons.chat,
        isCall ? 'Call to ${connectionState.contact.name}' : 'Chat request to ${connectionState.contact.name}');
  };
}


