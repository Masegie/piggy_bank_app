import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyEntryTile extends StatelessWidget {
  const MoneyEntryTile({
    Key key,
    @required this.deposit,
  }) : super(key: key);

  final Deposit deposit;

  @override
  Widget build(BuildContext context) {
    final depositBloc = Provider.of<DepositBloc>(context);
    return Dismissible(
      background: Container(
        color: Colors.redAccent,
      ),
      key: UniqueKey(),
      onDismissed: (direction) => depositBloc.removeDeposit(deposit),
        child: Container(
         decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
            )
          )
        ),
        child: ListTile(
          title: Text(deposit.amount.toString()),
          subtitle: Text(deposit.date.toString().substring(0,10)),
        ),
      ),
    );
  }
}