import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/data/model/contact.dart';
import 'package:archsampleapp/data/repositories/connection_repository.dart';
import 'package:flutter/material.dart';

import '../connection_bloc.dart';
import '../connection_router.dart';
import 'contact_details_layout.dart';

class ContactDetailsRoute extends MaterialPageRoute {
  static const name = '/contact-details';

  ContactDetailsRoute(
    ConnectionRepository connectionRepo,
    RouteSettings settings,
  ) : super(
          builder: (_) => _ContactDetailsScreenWidget(
            connectionRepo: connectionRepo,
          ),
          settings: settings,
        );
}

class _ContactDetailsScreenWidget extends StatelessWidget {
  final ConnectionRepository connectionRepo;

  const _ContactDetailsScreenWidget({super.key, required this.connectionRepo});

  @override
  Widget build(BuildContext context) {
    final contact = ModalRoute.of(context)?.settings.arguments as Contact;
    return BlocProvider(
      child: ContactDetailsLayout(contact),
      create: () => ConnectionBloc(connectionRepo),
      router: ConnectionRouter().onRoute,
    );
  }
}
