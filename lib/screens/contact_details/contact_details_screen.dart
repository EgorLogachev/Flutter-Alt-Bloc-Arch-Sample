import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/data/model/contact.dart';
import 'package:archsampleapp/data/repositories/connection_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../connection_bloc.dart';
import '../connection_router.dart';
import 'contact_details_layout.dart';

class ContactDetailsScreen {

  static const routeName = '/contact-details';

  static WidgetBuilder builder(ConnectionRepository repository) => (context) {
    final contact = ModalRoute.of(context)?.settings.arguments as Contact;
    return BlocProvider(
      child: ContactDetailsLayout(contact),
      create: () => ConnectionBloc(repository),
      router: ConnectionRouter().onRoute,
    );
  };
}


