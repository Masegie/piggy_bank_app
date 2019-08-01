import 'package:dram1y/models/deposit.dart';
import 'package:flutter/material.dart';

class MoneyEntryTile extends StatelessWidget {
  const MoneyEntryTile({
    Key key,
    @required this.deposit,
  }) : super(key: key);

  final Deposit deposit;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}