import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/home/pages/money_page.dart';
import 'package:dram1y/src/widgets/dreamName_label.dart';
import 'package:dram1y/src/widgets/dueDate_label.dart';
import 'package:dram1y/src/widgets/money_deficit_label.dart';
import 'package:dram1y/src/widgets/money_today_label.dart';
import 'package:dram1y/src/widgets/popups/reset_data_when_finished.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:firebase_database/firebase_database.dart';

class DepositPage extends StatefulWidget {
  final UserBloc userBloc;

  const DepositPage({Key key, this.userBloc, this.deposit}) : super(key: key);

  final Deposit deposit;

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {

  final DatabaseReference iotDatabase = FirebaseDatabase.instance.reference().child("distance");

  @override
  Widget build(BuildContext context) {
    var databaseIot = FirebaseDatabase.instance.reference().child('distance');
    final depositBloc = Provider.of<DepositBloc>(context);
    final userBloc = Provider.of<UserBloc>(context);
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: StreamBuilder<int>(
                stream: userBloc.outMaxMoney,
                initialData: 0,
                builder: (context, snapshot) {
                  final maxMoney = snapshot.data;
                  return StreamBuilder<int> (
                    stream: depositBloc.outDepositsAmount,
                    initialData: 0,
                    builder: (context,  snapshot) {
                      final maxAmount = snapshot.data;
                      if(maxAmount >= maxMoney){
                        return ResetDataWhenFinished();
                      }
                      else return StreamBuilder<Event>(
                        stream: databaseIot.onValue,
                        builder: (context,AsyncSnapshot<Event> snap) {
                          if(snap.data == null) {
                            return new Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18, left: 12, right: 12, bottom: 18),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Bentar yaa',
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                            fontFamily: 'Raleway',fontSize: 25,fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 18,),
                                        Image.asset('assets/icon_gif.gif',scale: 2.5,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          else 
                          {
                            DataSnapshot snapshot = snap.data.snapshot;
                            int distance = snapshot.value;
                            if(distance >=10){
                              return Column( 
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DueDateLabel(),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 481,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0)
                                      )
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        DreamNameLabel(),
                                        SizedBox(height: 20,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 170,
                                              height: 100,
                                              child: Material(
                                                color: Colors.green.shade200,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(25.0),
                                                  topLeft: Radius.circular(25.0),
                                                  bottomLeft: Radius.circular(25.0),
                                                  bottomRight: Radius.circular(25.0),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Tabungan',
                                                      style: new TextStyle(
                                                        fontSize: 30.0,
                                                        color: Colors.white,
                                                        fontFamily: 'Raleway'
                                                      ),
                                                    ),
                                                    MoneyTodayLabel(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 28.0,),
                                            Container(
                                              width: 170,
                                              height: 100,
                                              child: Material(
                                                color: Colors.red.shade200,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(25.0),
                                                  topLeft: Radius.circular(25.0),
                                                  bottomLeft: Radius.circular(25.0),
                                                  bottomRight: Radius.circular(25.0),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Kurang',
                                                      style: new TextStyle(
                                                        fontSize: 30.0,
                                                        color: Colors.white,
                                                        fontFamily: 'Raleway'
                                                      ),
                                                    ),
                                                    MoneyDeficitLabel(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),SizedBox(height: 20.0,),
                                        StreamBuilder<DateTime>(
                                          stream: userBloc.outSelectedLastDeposit,
                                          initialData: DateTime.now(),
                                          builder: (context,snapshot) {
                                            final date = snapshot.data;
                                            String formatDate = new DateFormat.yMMMd().format(date);
                                            return Text('');
                                          },
                                        ),
                                        Text(
                                          'Saya Senang',
                                          style: new TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.grey,
                                            fontFamily: 'Raleway'
                                          ),
                                        ),
                                        SizedBox(height: 20.0,),
                                        Image.asset('assets/icon_gif.gif',scale: 2.5,),
                                      ],
                                    ),
                                  ),      
                                ],
                              );
                            }
                            else {
                              return new MoneyPage();
                            } 
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
  Widget get largeSpace => SizedBox(height: 400);
}