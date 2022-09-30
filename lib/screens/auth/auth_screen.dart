import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

import 'auth_bloc.dart';
import 'auth_layout.dart';
import 'auth_router.dart';

class AuthRoute extends MaterialPageRoute {

  static const name = '/auth';

  AuthRoute(AuthRepository repository, RouteSettings settings)
      : super(
            builder: (_) => _AuthScreenWidget(
                  repository: repository,
                ),
            settings: settings);
}

class _AuthScreenWidget extends StatelessWidget {

  final AuthRepository repository;

  const _AuthScreenWidget({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    final extraData = ModalRoute.of(context)?.settings.arguments;
    return BlocProvider(
      child: AuthLayout(),
      create: () => AuthBloc(repository, extraData: extraData),
      router: AuthRouter().onRoute,
    );
  }
}

