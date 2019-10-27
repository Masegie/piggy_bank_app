import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/models/temp.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/widgets/money_entry_tile.dart';
import 'package:dram1y/src/widgets/money_entry_tile_temp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../root_page.dart';

class TempHistory extends StatelessWidget {
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
          color: Colors.white,
          onPressed: () async {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => RootPage(),
              )
            );
          } 
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
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
                        else return StreamBuilder<List<DepositTemp>>(
                          stream: depositBloc.outDepositsTemp,
                          initialData: [],
                          builder: (context, snapshot) {
                            final deposits = snapshot.data;
                            return ListView.builder(
                              itemCount: deposits.length,
                              itemBuilder: (context,index){
                                final deposit = deposits[index];
                                return MoneyEntryTileTemp(deposit: deposit);
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