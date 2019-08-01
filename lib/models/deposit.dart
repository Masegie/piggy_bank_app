import 'package:cloud_firestore/cloud_firestore.dart';

class Deposit{
  static const amountField = 'amount';
  static const dateField = 'date';

  Deposit(this.date, this.amount);
  
  Deposit.temp(){
    this.date = DateTime.now();
    this.amount = 0;
  }
  Deposit.fromDb(Map<String, dynamic> json){
    this.amount = json[amountField];
    this.date = json[dateField].toDate();
  }

  Map<String, dynamic> toJson(){
    return{
      amountField: this.amount,
      dateField: Timestamp.fromDate(this.date),
    };
  }

  // @override
  // String toString(){
  //   return 'amount: $amount,date: $date';
  // }

  DateTime date;
  int amount;
}