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
      dateField: Timestamp.fromDate(this.date),
      amountField: this.amount,
    };
  }
  DateTime date;
  int amount;
}