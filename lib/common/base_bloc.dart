import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/common/common_router.dart';
import 'package:archsampleapp/common/common_states.dart';
import 'package:archsampleapp/data/network/network_errors.dart';

class BaseBloc extends Bloc with _CommonErrorsHandler {

  BaseBloc() {
    /// You can create common states for the all instances of Bloc
    registerState<ProgressState>(initialState: ProgressState.hide());
  }

  void showProgress() => addState(ProgressState.show());

  void hideProgress() => addState(ProgressState.hide());
}

/// Override [handleError], [onConnectionError], [onAuthorizationError], [onUnexpectedError] for your Bloc to change error handling
mixin _CommonErrorsHandler on Bloc {

  void handleError(dynamic error) {
    if (error is ConnectionError) {
      onConnectionError();
    } else if (error is UnauthorizedError) {
      onAuthorizationError();
    } else {
      onUnexpectedError();
    }
  }

  void onConnectionError() {
    addNavigation(routeName: ErrorsRouter.connectionErrorRoute);
  }

  void onAuthorizationError() {
    addNavigation(routeName: ErrorsRouter.unauthorizedErrorRoute);
  }

  void onUnexpectedError() {
    addNavigation(routeName: ErrorsRouter.unexpectedErrorRoute);
  }
}
