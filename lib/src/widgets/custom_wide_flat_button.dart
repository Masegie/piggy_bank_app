import 'package:flutter/material.dart';

class CustomWideFlatButton extends StatelessWidget {
  const CustomWideFlatButton({
    Key key,
    this.text = 'Lanjut',
    @required this.onPressed,
    @required this.backgroundColor,
    @required this.foregroundColor,
    this.isRoundedAtBottom = true,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isRoundedAtBottom;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 90,vertical: 18),
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30)),
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Text(
          text,
          style: TextStyle(
            color: foregroundColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
        ]
      ),
    );
  }
}