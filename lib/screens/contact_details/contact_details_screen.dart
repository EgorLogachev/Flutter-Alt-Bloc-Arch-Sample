import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/data/model/contact.dart';
import 'package:archsampleapp/data/repositories/connection_repository.dart';
import 'package:archsampleapp/screens/connection/connection_bloc.dart';
import 'package:archsampleapp/screens/connection/connection_router.dart';
import 'package:archsampleapp/screens/contact_details/contact_details_bloc.dart';
import 'package:archsampleapp/screens/contact_details/contacts_details_use_case.dart';
import 'package:flutter/material.dart';
import 'contact_details_layout.dart';

class ContactDetailsRoute extends MaterialPageRoute {
  static const name = '/contact-details';

  ContactDetailsRoute(
    ContactDetailsUseCase useCase,
    RouteSettings settings,
  ) : super(
          builder: (_) => _ContactDetailsScreenWidget(
            contact: settings.arguments as Contact,
            useCase: useCase,
          ),
          settings: settings,
        );
}

class _ContactDetailsScreenWidget extends StatelessWidget {

  final Contact contact;
  final ContactDetailsUseCase useCase;

  const _ContactDetailsScreenWidget({
    super.key,
    required this.useCase,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: ContactDetailsLayout(contact),
      create: () => ContactDetailsBloc(useCase, contact),
      router: ConnectionRouter().onRoute,
    );
  }
}
