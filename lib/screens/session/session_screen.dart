import 'package:archsampleapp/data/model/contact.dart';
import 'package:archsampleapp/screens/connection/connection_bundle.dart';
import 'package:flutter/material.dart';

import 'session_layout.dart';

class SessionRoute extends MaterialPageRoute {
  static const name = '/connection';

  SessionRoute(RouteSettings settings)
      : super(
          builder: (_) {
            ConnectionBundle bundle = settings.arguments as ConnectionBundle;
            return _SessionScreenWidget(
              contact: bundle.contact,
              isCall: bundle.isCall,
            );
          },
          settings: settings,
        );
}

class _SessionScreenWidget extends StatelessWidget {
  final Contact contact;
  final isCall;

  const _SessionScreenWidget({
    super.key,
    required this.contact,
    required this.isCall,
  });

  @override
  Widget build(BuildContext context) {
    return SessionLayout(isCall ? Icons.call : Icons.chat,
        isCall ? 'Call to ${contact.name}' : 'Chat request to ${contact.name}');
  }
}
