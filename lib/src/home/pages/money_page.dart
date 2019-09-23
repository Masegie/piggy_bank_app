import 'package:dram1y/src/global_blocs/app_bloc.dart';
import 'package:dram1y/src/home/home_page_setup.dart';
import 'package:dram1y/src/widgets/buttons/moneyAmountButton.dart';
import 'package:dram1y/src/widgets/custom_wide_flat_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyPage extends StatelessWidget {
  final DatabaseReference iotDatabase = FirebaseDatabase.instance.reference().child("distance");

  
  @override
  Widget build(BuildContext context) {
    var databaseIot = FirebaseDatabase.instance.reference().child("distance");
    final depositBloc = Provider.of<AppBloc>(context).depositBloc;
    return Dialog(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20)
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: 0.85,
              padding: const EdgeInsets.all(12),
              children: <Widget>[
                MoneyAmountButton(amount: 1000),
                MoneyAmountButton(amount: 2000),
                MoneyAmountButton(amount: 5000),
                MoneyAmountButton(amount: 10000),
                MoneyAmountButton(amount: 20000),
                MoneyAmountButton(amount: 50000),
                MoneyAmountButton(amount: 100000),
                MoneyAmountButton(amount: 0),
              ],
            ),
          ),
          largeSpace,
          Expanded(
            flex: 0,
            child: StreamBuilder(
              stream: databaseIot.onValue,
              builder: (context, snap) {
                if(snap.hasData){
                  DataSnapshot snapshot = snap.data.snapshot;
                  if(snapshot == null){
                    HomePageSetup();
                  }
                  int distance = snapshot.value;
                  if(distance <= 9){
                    return FlatButton(
                      child: Text('Oke'),
                      color: Colors.green.shade300,
                      onPressed:() => depositBloc.depositMoney(),
                    );
                  }
                }
              }
            ),
          )
        ],
      ),
    );
  }
  Widget get largeSpace => SizedBox(height: 24);
}
