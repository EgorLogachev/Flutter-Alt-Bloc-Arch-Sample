import 'package:archsampleapp/common/common_router.dart';
import 'package:archsampleapp/data/model/contact.dart';
import 'package:archsampleapp/data/network/network_errors.dart';
import 'package:archsampleapp/data/repositories/connection_repository.dart';
import 'package:archsampleapp/screens/connection_router.dart';

import '../common/base_bloc.dart';

class ConnectionBloc extends BaseBloc {

  ConnectionBloc(this._repository);

  final ConnectionRepository _repository;

  Future startCall(Contact contact) async {
    return _startConnection(contact, (sessionId, contact) => CallConnectionState(sessionId, contact));
  }

  Future startChat(Contact contact) async {
    return _startConnection(contact, (sessionId, contact) => ChatConnectionState(sessionId, contact));
  }

  Future _startConnection(Contact contact, ConnectionState Function(int, Contact) stateCreator) async {
    try {
      showProgress();
      int sessionId = await _repository.fetchSession();
      addNavigation(routeName: ConnectionRouter.connectionRoute, arguments: stateCreator(sessionId, contact));
    } catch (e) {
      if (e is UnauthorizedError) {
        final result = await addNavigation(routeName: ErrorsRouter.unauthorizedErrorRoute, arguments: contact);
        _startConnection(result, stateCreator);
      } else {
        handleError(e);
      }
    } finally {
      hideProgress();
    }
  }
}

class ConnectionState {
  ConnectionState(this.sessionId, this.contact);

  final int sessionId;
  final Contact contact;
}

class ChatConnectionState extends ConnectionState {
  ChatConnectionState(int sessionId, Contact contact) : super(sessionId, contact);
}

class CallConnectionState extends ConnectionState {
  CallConnectionState(int sessionId, Contact contact) : super(sessionId, contact);
}