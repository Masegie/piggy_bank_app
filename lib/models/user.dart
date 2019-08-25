import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  static const lastLoggendInField = 'lastLoggedIn';
  static const moneyPerDayField = 'moneyPerDay';
  static const maxMoneyPerDayField = 'maxMoneyPerDay';
  static const dreamNameField = 'dreamName';

  User(this.lastLoggedIn, this.maxMoneyPerDay, this.dreamName);
  
  User.temp(){
    this.lastLoggedIn = DateTime.now();
    this.maxMoneyPerDay = 1;
    this.dreamName = "-";
  }
  User.fromDb(Map<String, dynamic> json){
    this.maxMoneyPerDay = json[maxMoneyPerDayField];
    this.lastLoggedIn = json[lastLoggendInField].toDate();
    this.dreamName = json[dreamNameField];
  }

  Map<String, dynamic> toJson(){
    return{
      lastLoggendInField: Timestamp.fromDate(this.lastLoggedIn),
      maxMoneyPerDayField: this.maxMoneyPerDay,
      dreamNameField: this.dreamName,
    };
  }
  DateTime lastLoggedIn;
  int maxMoneyPerDay;
  String dreamName;

  @override
  String toString() {
    return 'lastLoggedIn: $lastLoggedIn, maxMoneyPerDay: $maxMoneyPerDay, dreamName: $dreamName';
  }
}