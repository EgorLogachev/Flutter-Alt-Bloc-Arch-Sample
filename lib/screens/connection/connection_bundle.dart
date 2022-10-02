import 'package:archsampleapp/data/model/contact.dart';

class ConnectionBundle {
  ConnectionBundle({
    required this.sessionId,
    required this.contact,
    required this.isCall,
  });

  final int sessionId;
  final Contact contact;
  final bool isCall;
}
