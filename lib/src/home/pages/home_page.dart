import 'package:dram1y/models/deposit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';

class DepositPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    final depositBloc = Provider.of<DepositBloc>(context);
    return Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: StreamBuilder<int>(
                    stream: userBloc.outMaxMoney,
                    initialData: 0,
                    builder: (context, snapshot) {
                      final maxMoney = snapshot.data;
                      return Text(
                        'Rp 0/Rp.$maxMoney',
                        style: Theme.of(context).textTheme.title,
                        );
                    }
                  ),
                ),
                CircleAvatar(
                  radius: 84,
                  backgroundColor: Colors.greenAccent,
                ),
                // circle container with button
                //text
              ],
            )
          ),
          Expanded(
            flex: 3,
            child: StreamBuilder<List<Deposit>>(
              stream: depositBloc.outDeposits,
              initialData: [],
              builder: (context, snapshot) {
                final deposits = snapshot.data;
                return ListView.builder(
                  itemCount: deposits.length,
                  itemBuilder: (context,index){
                    return Text(deposits[index].amount.toString());
                  },
                );
              },
            ),
          )
        ] 
      );
  }
}