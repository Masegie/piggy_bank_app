import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class IotActifity extends StatefulWidget {
  @override
  _IotActifityState createState() => _IotActifityState();
}

class _IotActifityState extends State<IotActifity> {
 
  final DatabaseReference iotDatabase = FirebaseDatabase.instance.reference().child("distance");
  
  @override
  Widget build(BuildContext context) {
    var databaseIot = FirebaseDatabase.instance.reference().child("distance");
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase"),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder(
        
        stream: databaseIot.onValue,
        initialData: 0,
        builder: (context, snap) {
          DataSnapshot snapshot = snap.data.snapshot;
          int distance = snapshot.value;
          return Text("$distance");
        },
      )
    );
  }
}