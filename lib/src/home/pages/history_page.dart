import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/pages/onboarding_page_dream.dart';
import 'package:dram1y/src/widgets/money_entry_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../root_page.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final depositBloc = Provider.of<DepositBloc>(context);
    final userBloc = Provider.of<UserBloc>(context);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.green.shade300,
          onPressed: () async {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => OnboardingDreamPage(),
              )
            );
          } 
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Image.asset('assets/selamat.png',scale: 1.4,),
             SizedBox(height: 50,),
             FlatButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                padding: const EdgeInsets.all(12),
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => OnboardingDreamPage(),
                    )
                  );
                }, 
                child: Text('Buat Lagi !',
                style: new TextStyle(
                    fontFamily: 'Raleway',fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white
                  ),),
                color: Colors.green.shade200,
              ),
            // Text('Selamat Telah Menyelesaikan Mimpi mu Ayo  buat mimpi lagi!',
            //   style: TextStyle(fontFamily: 'Raleway',fontSize: 17),
            // ),
            // Image.asset('assets/chiken.gif',scale: 1.2,),
            // FlatButton(
            //   child: Text('Oke'),
            //   onPressed: () async {
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //         builder: (context) => OnboardingDreamPage(),
            //       )
            //     );
            //   },
            // ),
            Expanded(
                flex: 3,
                child: StreamBuilder<int>(
                  stream: userBloc.outMaxMoney,
                  initialData: 0,
                  builder: (context,snapshot) {
                    final maxMoney = snapshot.data;
                    return StreamBuilder<int>(
                      stream: depositBloc.outDepositsAmount,
                      initialData: 0,
                      builder: (context,snapshot) {
                        final maxAmount = snapshot.data;
                        if(maxAmount >= maxMoney){
                          return StreamBuilder<List<Deposit>>(
                            stream: depositBloc.outDeposits,
                            initialData: [],
                            builder: (context, snapshot) {
                              final deposits = snapshot.data;
                              return ListView.builder(
                                itemCount: deposits.length,
                                itemBuilder: (context,index){
                                  final deposit = deposits[index];
                                  depositBloc.removeDeposit(deposit);
                            //      return Text('delete');
                                  //return Text("$deposit");
                                },
                              );
                            },
                          );
                        }
                        else return StreamBuilder<List<Deposit>>(
                          stream: depositBloc.outDeposits,
                          initialData: [],
                          builder: (context, snapshot) {
                            final deposits = snapshot.data;
                            return ListView.builder(
                              itemCount: deposits.length,
                              itemBuilder: (context,index){
                                final deposit = deposits[index];
                                return MoneyEntryTile(deposit: deposit);
                              // depositBloc.removeDeposit(deposit);
                                //return Text("$deposit");
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                )
              ),
          ],
        ),
      ),
    );
  }
}
// StreamBuilder<List<Deposit>>(
//                   stream: depositBloc.outDeposits,
//                   initialData: [],
//                   builder: (context, snapshot) {
//                     final deposits = snapshot.data;
//                     return ListView.builder(
//                       itemCount: deposits.length,
//                       itemBuilder: (context,index){
//                         final deposit = deposits[index];
//                         return MoneyEntryTile(deposit: deposit);
//                        // depositBloc.removeDeposit(deposit);
//                         //return Text("$deposit");
//                       },
//                     );
//                   },
//                 ),
