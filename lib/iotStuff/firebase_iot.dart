import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class IotActifity extends StatefulWidget {
  @override
  _IotActifityState createState() => _IotActifityState();
}

class _IotActifityState extends State<IotActifity> {
 
  
  final DatabaseReference database = FirebaseDatabase.instance.reference().child("test");
  final DatabaseReference iotDatabase = FirebaseDatabase.instance.reference().child("distance");
  sendData() {
    database.push().set({
      'name' : 'Chuck',
      'lastName' : 'Norris'
    });
  }

  readData(){
    database.once().then((DataSnapshot dataSnapShot){
      print(dataSnapShot.value);
    });
  }

  readDataIot(){
    iotDatabase.once().then((DataSnapshot dataSnapShot){
      print(dataSnapShot.value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase"),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder(
        
        stream: iotDatabase.onValue,
        initialData: 0,
        builder: (context, snapshot) {
          final text = snapshot.data;
          return Text("$text");
        },
      )
    );
  }
}