import 'package:dram1y/src/global_blocs/app_bloc.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/utils/asset_util.dart';
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
    final depositBloc = Provider.of<AppBloc>(context).depositBloc;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
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
                  return CupImage(
                  amount: amount,
                  isSelected: selectedAmount == amount,
                );
                },
              ),
          ),
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

class CupImage extends StatelessWidget {
  const CupImage({
    Key key,
    @required this.amount,
    @required this.isSelected,
    this.width = 60,
    this.height = 60,
  }) : super(key: key);

  final int amount;
  final bool isSelected;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetUtil.assetImage(amount),
      width: isSelected ? width + 40 : width,
      height: isSelected ? height + 40 : height,
    );
  }
}
