import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/data/repositories/connection_repository.dart';
import 'package:archsampleapp/data/repositories/contacts_repository.dart';
import 'package:flutter/material.dart';

import '../connection_bloc.dart';
import 'contacts_bloc.dart';
import 'contacts_layout.dart';
import 'contacts_router.dart';


class ContactsRoute extends MaterialPageRoute {

  static const name = '/';

  ContactsRoute(
    ContactsRepository contactsRepo,
    ConnectionRepository connectionRepo,
    RouteSettings settings,
  ) : super(
          builder: (_) => _ContactsScreenWidget(
            connectionRepo: connectionRepo,
            contactsRepo: contactsRepo,
          ),
          settings: settings,
        );
}

class _ContactsScreenWidget extends StatelessWidget {

  final ContactsRepository contactsRepo;
  final ConnectionRepository connectionRepo;

  const _ContactsScreenWidget({
    super.key,
    required this.contactsRepo,
    required this.connectionRepo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsBloc>(
      child: ContactsLayout(),
      create: () => ContactsBloc(contactsRepo, ConnectionBloc(connectionRepo)),
      router: ContactsRouter().onRoute,
    );

  }
}


