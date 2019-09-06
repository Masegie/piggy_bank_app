import 'package:dram1y/src/home/home_page_setup.dart';
import 'package:dram1y/src/home/pages/dream_page.dart';
import 'package:dram1y/src/home/pages/home_page.dart';
import 'package:dram1y/src/widgets/buttons/custom_wide_flat_button.dart';
import 'package:dram1y/src/widgets/buttons/moneyAmountButton.dart';
import 'package:flutter/material.dart';

class MoneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: 0.85,
              padding: const EdgeInsets.all(12),
              children: <Widget>[
                MoneyAmountButton(amount: 1000),
                MoneyAmountButton(amount: 2000),
                MoneyAmountButton(amount: 5000),
                MoneyAmountButton(amount: 10000),
                MoneyAmountButton(amount: 20000),
                MoneyAmountButton(amount: 50000),
                MoneyAmountButton(amount: 100000),
                MoneyAmountButton(amount: 0),
              ],
            ),
          ),
          largeSpace,
          CustomWideFlatButton(
            onPressed: () => HistoryPage(),
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.blue.shade900,
            text: "Ok",
          ),
        ],
      ),
    );
  }
  Widget get largeSpace => SizedBox(height: 24);
}
