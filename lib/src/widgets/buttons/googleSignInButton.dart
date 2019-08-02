import 'package:dram1y/src/global_blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return ButtonTheme(
      minWidth: 224,               
      child: FlatButton(
        onPressed: authBloc.signInWithGoogle,
        child: Text('Google Sign in'),
      ),
    );
  }
}