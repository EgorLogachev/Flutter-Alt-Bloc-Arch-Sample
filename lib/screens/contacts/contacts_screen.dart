import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/data/repositories/connection_repository.dart';
import 'package:archsampleapp/data/repositories/contacts_repository.dart';
import 'package:archsampleapp/screens/contacts/contacts_use_case.dart';
import 'package:flutter/material.dart';

import '../connection/connection_bloc.dart';
import 'contacts_bloc.dart';
import 'contacts_layout.dart';
import 'contacts_router.dart';


class ContactsRoute extends MaterialPageRoute {

  static const name = '/';

  ContactsRoute(
    ContactsUseCase useCase,
    RouteSettings settings,
  ) : super(
          builder: (_) => _ContactsScreenWidget(
            useCase: useCase,
          ),
          settings: settings,
        );
}

class _ContactsScreenWidget extends StatelessWidget {

  final ContactsUseCase useCase;

  const _ContactsScreenWidget({
    super.key,
    required this.useCase,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsBloc>(
      child: ContactsLayout(),
      create: () => ContactsBloc(useCase),
      router: ContactsRouter().onRoute,
    );

  }
}
