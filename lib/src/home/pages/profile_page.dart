import 'package:dram1y/iotStuff/firebase_iot.dart';
import 'package:dram1y/src/root_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.grey,
        ),
        title: const Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
          onPressed: () async {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => RootPage(),
              )
            );
          } 
        ),
      ),
      body: FlatButton(
        child: Text('daf'),
        color: Colors.amber,
        onPressed: () async {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => IotActifity(),
              )
            );
          } 
      ),
    );
  }
}