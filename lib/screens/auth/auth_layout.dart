import 'package:alt_bloc/alt_bloc.dart';
import 'package:flutter/material.dart';

import 'auth_bloc.dart';

class AuthLayout extends StatefulWidget {
  AuthLayout() : super();

  @override
  State<StatefulWidget> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: WillPopScope(
            onWillPop: () async {
              Provider.of<AuthBloc>(context).close();
              return false;
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 16.0,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'Email (Optional)'),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(hintText: 'Password (Optional)'),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  BlocBuilder<AuthBloc, BadCredentialsState>(builder: (_, state) {
                    return state == null
                        ? Container()
                        : Text(
                      'You have entered an invalid email or password',
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Colors.redAccent),
                    );
                  }),
                  SizedBox(
                    height: 8.0,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<AuthBloc, bool>(
                        builder: (_, progress) {
                          return RaisedButton(
                              child: progress
                                  ? SizedBox(
                                child: CircularProgressIndicator(),
                                width: 24.0,
                                height: 24.0,
                              )
                                  : Text('Sign In'),
                              onPressed: () {
                                Provider.of<AuthBloc>(context).signIn(_emailController.text, _passwordController.text);
                              });
                        },
                      ))
                ],
              ),
            ))
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}