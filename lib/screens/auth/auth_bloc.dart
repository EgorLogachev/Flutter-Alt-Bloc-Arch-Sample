import 'package:archsampleapp/data/network/network_errors.dart';
import 'package:archsampleapp/data/repositories/auth_repository.dart';

import '../../common/base_bloc.dart';
import 'auth_router.dart';

class AuthBloc extends BaseBloc {

  final AuthRepository _repository;

  AuthBloc(this._repository, {this.extraData}) {
    registerState<BadCredentialsState>();
  }

  final extraData;

  Future signIn(String email, String password) async {
    addState<BadCredentialsState>(null);
    try {
      showProgress();
      await _repository.signIn(email, password);
      addNavigation(
          routeName: extraData == null ? AuthRouter.contactsRoute : AuthRouter.closeScreenRoute,
          arguments: extraData);
    } catch (e) {
      handleError(e);
    } finally {
      hideProgress();
    }
  }

  @override
  void handleError(Error error) {
    if (error is BadCredentialsError) {
      addState<BadCredentialsState>(BadCredentialsState());
    } else {
      super.handleError(error);
    }
  }

  void close() {
    addNavigation(routeName: AuthRouter.closeAppRoute);
  }
}

class BadCredentialsState {}
