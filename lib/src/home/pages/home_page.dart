import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
//import 'package:dram1y/src/home/pages/dream_page.dart';
import 'package:dram1y/src/widgets/buttons/circle_money_button.dart';
import 'package:dram1y/src/widgets/dreamName_label.dart';
import 'package:dram1y/src/widgets/dueDate_label.dart';
import 'package:dram1y/src/widgets/money_entry_tile.dart';
import 'package:dram1y/src/widgets/money_today_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';

class DepositPage extends StatelessWidget {
  final UserBloc userBloc;

  const DepositPage({Key key, this.userBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final depositBloc = Provider.of<DepositBloc>(context);
    return Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                DueDateLabel(),
                DreamNameLabel(),
                MoneyTodayLabel(),
                CircleButton(),
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