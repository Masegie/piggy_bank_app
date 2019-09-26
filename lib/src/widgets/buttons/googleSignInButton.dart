import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key key, 
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 224,
      height: 50,      
      child: FlatButton.icon(
        onPressed: onPressed,
        color: Colors.white,
        icon: Image.asset('assets/google_icon.png',scale: 30,),
        label: Text('Login With Google'),
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
      ),
    );
  }
}