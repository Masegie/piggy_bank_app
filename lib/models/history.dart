import 'package:cloud_firestore/cloud_firestore.dart';

class History{
  static const amountField = 'amount';
  static const dateField = 'date';
  static const dreamNameField = 'dreamName';

  History(this.date, this.amount, this.dreamName);
  
  History.temp(){
    this.date = DateTime.now();
    this.amount = 0;
    this.dreamName = '';
  }
  History.fromDb(Map<String, dynamic> json,String id){
    this.id = id;
    this.dreamName = json[dreamNameField];
    this.amount = json[amountField];
    this.date = json[dateField].toDate();
  }

  Map<String, dynamic> toJson(){
    return{
      amountField: this.amount,
      dreamNameField: this.dreamName,
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
  String dreamName;
}
