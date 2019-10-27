import 'package:cloud_firestore/cloud_firestore.dart';

class DepositTemp{
  static const amountField = 'amount';
  static const dateField = 'date';

  DepositTemp(this.date, this.amount);
  
  DepositTemp.temp(){
    this.date = DateTime.now();
    this.amount = 0;
  }
  DepositTemp.fromDb(Map<String, dynamic> json,String id){
    this.id = id;
    this.amount = json[amountField];
    this.date = json[dateField].toDate();
  }

  Map<String, dynamic> toJson(){
    return{
      amountField: this.amount,
      dateField: Timestamp.fromDate(this.date),
    };
  }

  @override
  String toString(){
    return 'amount: $amount,date: $date';
  }

  String id;
  DateTime date;
  int amount;
}
