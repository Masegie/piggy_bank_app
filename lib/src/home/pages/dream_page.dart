import 'package:flutter/material.dart';

class DreamPage extends StatefulWidget {
  @override
  _DreamPageState createState() => _DreamPageState();
}

class _DreamPageState extends State<DreamPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Input Your Dream',
            style: Theme.of(context).textTheme.title.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          smallSpace,
        ],
      ),
    );
  }

  Widget get smallSpace => SizedBox(height: 12);
  Widget get largeSpace => SizedBox(height: 24);
}