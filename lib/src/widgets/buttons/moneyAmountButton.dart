import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/widgets/custom_amount_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyAmountButton extends StatelessWidget {
  const MoneyAmountButton({
    Key key,
    this.amount = 0,
  }) : super(key:key);

  final int amount;
 
  @override
  Widget build(BuildContext context) {
    final depositBloc = Provider.of<DepositBloc>(context);
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                if(amount == 0) {
                  setCustomAmount(depositBloc,context);
                } else {
                  setAmount(depositBloc);
                }
              },
              child: StreamBuilder<int>(
                stream: depositBloc.outSelectedAmount,
                initialData: 1,
                builder: (context,snapshot) {
                  final selectedAmount = snapshot.data;
                  return Placeholder(color: selectedAmount == amount ? Colors.blue : Colors.black);
                },
              ),
            ),
          ),
          SizedBox(height: 4),
          if (amount != 0 ) Text('RP. $amount') else Text('Custom'),
        ],
      ),
    );
  } 

  void setCustomAmount(DepositBloc depositBloc, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CustomAmountPopup();
      }
    );
  }

  void setAmount(DepositBloc depositBloc) {
    depositBloc.setDepositAmount = amount;
  }
}