import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyTodayLabel extends StatelessWidget {
  const MoneyTodayLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    final depositBloc = Provider.of<DepositBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder<int>(
        stream: userBloc.outMaxMoney,
        initialData: 0,
        builder: (context, snapshot) {
          final maxMoney = snapshot.data;
          return StreamBuilder<int>(
            stream: depositBloc.outDepositsAmount,
            initialData: 90,
            builder: (context, snapshot) {
              final moneyAmount = snapshot.data;
              return Text(
                'Rp. $moneyAmount/Rp.$maxMoney',
                style: Theme.of(context).textTheme.title,
              );
            },
          );
        }
      ),
    );
  }
}