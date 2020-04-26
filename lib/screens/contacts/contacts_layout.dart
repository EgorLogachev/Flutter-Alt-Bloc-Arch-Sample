import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/data/model/contact.dart';
import 'package:flutter/material.dart';

import 'contacts_bloc.dart';

class ContactsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: Stack(
          children: <Widget>[
            BlocBuilder<ContactsBloc, List<Contact>>(
              builder: (_, contacts) {
                return RefreshIndicator(
                    onRefresh: () => Provider.of<ContactsBloc>(context).getContacts(),
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        final contact = contacts[index];
                        return GestureDetector(
                          onTap: () {
                            Provider.of<ContactsBloc>(context).showDetails(contact);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    contact.name,
                                    style: Theme.of(context).textTheme.display2,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Ink(
                                  child: IconButton(
                                      icon: Icon(Icons.call),
                                      color: Colors.white,
                                      onPressed: () => Provider.of<ContactsBloc>(context).startCall(contact)),
                                  decoration: const ShapeDecoration(shape: CircleBorder(), color: Colors.black),
                                ),
                                SizedBox(
                                  width: 24.0,
                                ),
                                Ink(
                                  child: IconButton(
                                      icon: Icon(Icons.chat),
                                      color: Colors.white,
                                      onPressed: () => Provider.of<ContactsBloc>(context).startChat(contact)),
                                  decoration: const ShapeDecoration(shape: CircleBorder(), color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => Divider(),
                      itemCount: contacts.length,
                    ));
              },
            ),
            BlocBuilder<ContactsBloc, bool>(
              builder: (_, progress) {
                return progress ? Center(child: CircularProgressIndicator(),) : Container();
              },
            )
          ],
        ));
  }
}