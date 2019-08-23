import 'package:dram1y/src/global_blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnonymousSignInButton extends StatelessWidget {
  const AnonymousSignInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return ButtonTheme(
      minWidth: 224,
      height: 48,           
      child: RaisedButton(
        onPressed: authBloc.signInAnonymously,
        color: Colors.blue.shade200,
        child: Text('Anonymous Sign in'),
      ),
    );
  }
}