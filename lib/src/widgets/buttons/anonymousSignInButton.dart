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
      child: FlatButton.icon(
        onPressed: authBloc.signInAnonymously,
        color: Colors.greenAccent[100],
        icon: Icon(Icons.person),
        label: Text('Anonymous Sign in'),
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
      ),
    );
  }
}