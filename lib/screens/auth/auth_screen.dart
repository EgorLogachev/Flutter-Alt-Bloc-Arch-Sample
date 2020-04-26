import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

import 'auth_bloc.dart';
import 'auth_layout.dart';
import 'auth_router.dart';

class AuthScreen {

  static const routeName = '/auth';

  static WidgetBuilder builder(AuthRepository repository) => (context) {
    final extraData = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
      child: AuthLayout(),
      create: () => AuthBloc(repository, extraData: extraData),
      router: AuthRouter().onRoute,
    );
  };
}
