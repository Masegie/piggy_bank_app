import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/widgets/money_entry_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final depositBloc = Provider.of<DepositBloc>(context);
    return  Column(
       children: <Widget>[
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
          ),
       ],
    );
  }
}