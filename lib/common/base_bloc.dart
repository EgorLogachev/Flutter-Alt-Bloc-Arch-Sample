import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/common/common_router.dart';
import 'package:archsampleapp/data/network/network_errors.dart';

class BaseBloc extends Bloc with _CommonErrorsHandler {

  BaseBloc() {
    registerState<bool>(initialState: false);
  }

  //todo change it
  void showProgress() => addState<bool>(true);
  //todo change it
  void hideProgress() => addState<bool>(false);
}

mixin _CommonErrorsHandler on Bloc {

  void handleError(dynamic error) {
    if (error is ConnectionError) {
      addNavigation(routeName: ErrorsRouter.connectionErrorRoute);
    } else if (error is UnauthorizedError) {
      addNavigation(routeName: ErrorsRouter.unauthorizedErrorRoute);
    } else {
      addNavigation(routeName: ErrorsRouter.unexpectedErrorRoute);
    }
  }
}