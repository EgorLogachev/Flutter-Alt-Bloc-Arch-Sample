import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/data/repositories/connection_repository.dart';
import 'package:archsampleapp/data/repositories/contacts_repository.dart';
import 'package:flutter/material.dart';

import '../connection_bloc.dart';
import 'contacts_bloc.dart';
import 'contacts_layout.dart';
import 'contacts_router.dart';

class ContactsScreen {

  static const routeName = '/contacts';

  static WidgetBuilder builder(ContactsRepository contRepository, ConnectionRepository connRepository) => (context) {
    return BlocProvider<ContactsBloc>(
      child: ContactsLayout(),
      create: () => ContactsBloc(contRepository, ConnectionBloc(connRepository)),
      router: ContactsRouter().onRoute,
    );
  };
}


