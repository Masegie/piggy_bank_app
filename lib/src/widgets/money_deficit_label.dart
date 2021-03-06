import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyDeficitLabel extends StatefulWidget {
  const MoneyDeficitLabel({
    Key key,
  }) : super(key: key);

  @override
  _MoneyDeficitLabelState createState() => _MoneyDeficitLabelState();
}

class _MoneyDeficitLabelState extends State<MoneyDeficitLabel> with SingleTickerProviderStateMixin {
  AnimationController _fadeInController;
  
  @override
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

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
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final moneyAmount  = snapshot.data;
                final deficit =  maxMoney - moneyAmount;
                _fadeInController.forward();
                return AnimatedBuilder(
                  animation: _fadeInController,
                  builder: (context,child) {
                    return Column(
                      children: <Widget>[
                        Text(
                          'Rp $deficit',
                          style: new TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontFamily: 'Raleway'
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          );
        }
      ),
    );
  }
}