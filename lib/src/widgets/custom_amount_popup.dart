import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAmountPopup extends StatefulWidget {
  @override
  _CustomAmountPopupState createState() => _CustomAmountPopupState();
}

class _CustomAmountPopupState extends State<CustomAmountPopup> {
  final _controller = TextEditingController();
  Icon _errorIcon;

  @override
  Widget build(BuildContext context) {
    final depositBloc = Provider.of<DepositBloc>(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18, left: 12, right: 12),
          child: Column(
            children: <Widget>[
              Text(
                'Enter Your Amount',
                style: Theme.of(context).textTheme.title.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              smallSpace,
              Text(
                'Change the amount field with your custom amount',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle.copyWith(
                  color: Colors.black,
                ),
              ),
              largeSpace,
              Padding(
               padding: const EdgeInsets.all(8),
               child: Container(
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) => setValue(value,depositBloc),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: _errorIcon,
                    suffixText: 'rupiah',
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5)
                        )
                      )
                    ),
                  ),
                )
              )
            ],
          ),
        ),
        largeSpace,
        okButton(depositBloc,context),
      ],),
    );
  }

  FlatButton okButton(DepositBloc depositBloc, BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.all(0),
      onPressed: () => setValue(_controller.text, depositBloc),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        )
      ),
      color: Theme.of(context).accentColor,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        child: Text('Ok'),
      ),
    );
  }

  Widget get largeSpace => SizedBox(height: 24);
  Widget get smallSpace => SizedBox(height: 12);

  void setValue(String amountAsString, DepositBloc depositBloc) {
    Icon error = Icon(Icons.error, color: Colors.red,);
    if(amountAsString.isEmpty) {
      setState(() {
       _errorIcon = error; 
      });
      return;
    }
    setState(() {
     _errorIcon = null; 
    });

    int amount = int.parse(amountAsString);
    depositBloc.setDepositAmount = amount;
    Navigator.of(context).pop();
  }
}