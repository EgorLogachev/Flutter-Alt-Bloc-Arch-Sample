import 'package:alt_bloc/alt_bloc.dart';
import 'package:archsampleapp/data/model/contact.dart';
import 'package:archsampleapp/screens/contact_details/contact_details_bloc.dart';
import 'package:flutter/material.dart';

class ContactDetailsLayout extends StatelessWidget {
  const ContactDetailsLayout(this._contact);

  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ContactDetailsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.black12,
              backgroundImage: NetworkImage(
                  'https://static.vecteezy.com/system/resources/thumbnails/001/993/889/small/beautiful-latin-woman-avatar-character-icon-free-vector.jpg'),
              radius: 100.0,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              _contact.name,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: Colors.black87),
            ),
            BlocBuilder<ContactDetailsBloc, String>(
              builder: (context, description) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                  child: Text(
                    description,
                  ),
                );
              },
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Ink(
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(), color: Colors.black),
                    padding: EdgeInsets.all(8.0),
                    child: IconButton(
                        iconSize: 48.0,
                        icon: Icon(Icons.call),
                        color: Colors.white,
                        onPressed: () => bloc.startCall()),
                  )),
                  Expanded(
                    child: Ink(
                      decoration: const ShapeDecoration(
                          shape: CircleBorder(), color: Colors.black),
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                          iconSize: 48.0,
                          icon: Icon(Icons.chat),
                          color: Colors.white,
                          onPressed: () => bloc.startChat()),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
