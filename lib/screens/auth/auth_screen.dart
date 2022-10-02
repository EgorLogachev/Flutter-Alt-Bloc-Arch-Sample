import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/screens/auth/auth_use_case.dart';
import 'package:flutter/material.dart';

import 'auth_bloc.dart';
import 'auth_layout.dart';
import 'auth_router.dart';

class AuthRoute extends MaterialPageRoute {
  static const name = '/auth';

  AuthRoute(SignInUseCase _useCase, RouteSettings settings)
      : super(
          builder: (_) => _AuthScreenWidget(
            useCase: _useCase,
            extraData: settings.arguments,
          ),
          settings: settings,
        );
}

class _AuthScreenWidget extends StatelessWidget {
  final SignInUseCase useCase;
  final extraData;

  const _AuthScreenWidget({super.key, required this.useCase, this.extraData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: AuthLayout(),
      create: () => AuthBloc(useCase, extraData: extraData),
      router: AuthRouter().onRoute,
    );
  }
}
