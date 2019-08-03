import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/home/pages/dream_page.dart';
import 'package:dram1y/src/widgets/buttons/circle_money_button.dart';
import 'package:dram1y/src/widgets/money_entry_tile.dart';
import 'package:dram1y/src/widgets/money_today_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';

class DepositPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final depositBloc = Provider.of<DepositBloc>(context);
    final userBloc = Provider.of<UserBloc>(context);
    return Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: StreamBuilder<int>(
              stream: userBloc.outMaxMoney,
              initialData: 0,
              builder: (context, snapshot) {
                final maxMoney = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if(maxMoney != 1)
                    MoneyTodayLabel(),
                    if(maxMoney != 1)
                    CircleButton(),
                    if(maxMoney >= 1)
                    DreamPage(),
                  ],
                );
              }
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
                    final deposit = deposits[index];
                    return MoneyEntryTile(deposit: deposit);
                  },
                );
              },
            ),
          )
        ] 
      );
  }
}