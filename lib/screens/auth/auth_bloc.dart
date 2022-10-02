import 'package:archsampleapp/screens/auth/auth_use_case.dart';

import '../../common/base_bloc.dart';
import '../../data/api/auth_api_error.dart';
import 'auth_router.dart';

class AuthBloc extends BaseBloc {

  final SignInUseCase _useCase;

  AuthBloc(this._useCase, {this.extraData}) {
    registerState<BadCredentialsState?>();
  }

  final extraData;

  Future signIn(String email, String password) async {
    /// notify UI about data
    addState<BadCredentialsState?>(null);
    try {
      showProgress();
      await _useCase.signIn(email, password);
      /// notify about navigation event
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
  void handleError(dynamic error) {
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
