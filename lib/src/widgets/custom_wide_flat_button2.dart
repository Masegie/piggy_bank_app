import 'package:flutter/material.dart';

class CustomWideFlatButton2 extends StatelessWidget {
  const CustomWideFlatButton2({
    Key key,
    this.text = 'Next',
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
      
      padding: EdgeInsets.all(0),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      color: backgroundColor,
      child: Container(
        alignment: Alignment.center,
        height: 81,
        width: double.infinity,
        child: Text(
          text,
          style: TextStyle(
            color: foregroundColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
      )
    );
  }
}