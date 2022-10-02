import 'package:archsampleapp/common/base_bloc.dart';
import 'package:archsampleapp/common/common_router.dart';
import 'package:archsampleapp/data/model/contact.dart';
import 'package:archsampleapp/data/network/network_errors.dart';
import 'package:archsampleapp/screens/connection/connection_router.dart';
import 'package:archsampleapp/screens/connection/connection_bundle.dart';
import 'package:archsampleapp/screens/connection/connection_use_case.dart';


class ConnectionBloc extends BaseBloc {

  ConnectionBloc(this._useCase);

  final ConnectionUseCase _useCase;

  Future startCall(Contact contact) async => _startConnection(contact, true);

  Future startChat(Contact contact) async => _startConnection(contact, false);

  Future _startConnection(Contact contact, bool isCall) async {
    try {
      showProgress();
      int sessionId = await _useCase.fetchSession();
      final bundle = ConnectionBundle(
        sessionId: sessionId,
        contact: contact,
        isCall: isCall,
      );
      addNavigation(
        routeName: ConnectionRouter.sessionRoute,
        arguments: bundle,
      );
    } catch (e) {
      if (e is UnauthorizedError) {
        final result = await addNavigation(routeName: ErrorsRouter.unauthorizedErrorRoute, arguments: contact);
        _startConnection(result, isCall);
      } else {
        handleError(e);
      }
    } finally {
      hideProgress();
    }
  }
}
