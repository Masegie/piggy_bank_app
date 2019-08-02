import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  static const lastLoggendInField = 'lastLoggedIn';
  static const moneyPerDayField = 'moneyPerDay';
  static const maxMoneyPerDayField = 'maxMoneyPerDay';

  User(this.lastLoggedIn, this.maxMoneyPerDay);
  
  User.temp(){
    this.lastLoggedIn = DateTime.now();
    this.maxMoneyPerDay = 200000;
  }
  User.fromDb(Map<String, dynamic> json){
    this.maxMoneyPerDay = json[maxMoneyPerDayField];
    this.lastLoggedIn = json[lastLoggendInField].toDate();
  }

  Map<String, dynamic> toJson(){
    return{
      lastLoggendInField: Timestamp.fromDate(this.lastLoggedIn),
      maxMoneyPerDayField: this.maxMoneyPerDay,
    };
  }
  DateTime lastLoggedIn;
  int maxMoneyPerDay;
}