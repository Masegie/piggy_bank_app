import 'package:dram1y/src/home/home_page_setup.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
          if(distance >=50){
            return Text("$distance");
          }
          else {
            return new HomePageSetup();
          }
        },
      )
    );
  }
}