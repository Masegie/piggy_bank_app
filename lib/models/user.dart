import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  static const lastLoggendInField = 'lastLoggedIn';
  static const moneyPerDayField = 'moneyPerDay';

  User(this.lastLoggedIn, this.moneyPerDay);
  
  User.temp(){
    this.lastLoggedIn = DateTime.now();
    this.moneyPerDay = 0;
  }
  User.fromDb(Map<String, dynamic> json){
    this.moneyPerDay = json[moneyPerDayField];
    this.lastLoggedIn = json[lastLoggendInField].toDate();
  }

  Map<String, dynamic> toJson(){
    return{
      lastLoggendInField: Timestamp.fromDate(this.lastLoggedIn),
      moneyPerDayField: this.moneyPerDay,
    };
  }
  int moneyPerDay;
  DateTime lastLoggedIn;
}