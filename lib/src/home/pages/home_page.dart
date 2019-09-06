import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/home/pages/money_page.dart';
//import 'package:dram1y/src/home/pages/dream_page.dart';
import 'package:dram1y/src/widgets/buttons/circle_money_button.dart';
import 'package:dram1y/src/widgets/dreamName_label.dart';
import 'package:dram1y/src/widgets/dueDate_label.dart';
import 'package:dram1y/src/widgets/money_entry_tile.dart';
import 'package:dram1y/src/widgets/money_today_label.dart';
import 'package:dram1y/src/widgets/popups/reset_data_when_finished.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:firebase_database/firebase_database.dart';

class DepositPage extends StatefulWidget {
  final UserBloc userBloc;

  const DepositPage({Key key, this.userBloc}) : super(key: key);

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {

  final DatabaseReference iotDatabase = FirebaseDatabase.instance.reference().child("distance");

  @override
  Widget build(BuildContext context) {
    var databaseIot = FirebaseDatabase.instance.reference().child("distance");
    final depositBloc = Provider.of<DepositBloc>(context);
    final userBloc = Provider.of<UserBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: StreamBuilder<int>(
                stream: userBloc.outMaxMoney,
                initialData: 0,
                builder: (context, snapshot) {
                  final maxMoney = snapshot.data;
                  return StreamBuilder<int>(
                    stream: depositBloc.outDepositsAmount,
                    initialData: 0,
                    builder: (context, snapshot) {
                      final maxAmount = snapshot.data;
                      if(maxAmount >= maxMoney){
                        return ResetDataWhenFinished();
                      }
                      else return StreamBuilder<Event>(
                        stream: databaseIot.onValue,
                        builder: (context, snap) {
                          DataSnapshot snapshot = snap.data.snapshot;
                          int distance = snapshot.value;
                          if(distance >=50){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                DueDateLabel(),
                                DreamNameLabel(),                                                                   
                                MoneyTodayLabel(),
                                CircleButton(),
                              ],
                            );
                          }
                          else {
                            return new MoneyPage();
                          } 
                        }
                      );
                    }
                  );
                }
              ),
            ),
          ] 
        ),
      ),
      
    );
  }
}