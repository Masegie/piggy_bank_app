import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  static const lastLoggendInField = 'lastLoggedIn';
  static const moneyPerDayField = 'moneyPerDay';
  static const maxMoneyPerDayField = 'maxMoneyPerDay';
  static const dreamNameField = 'dreamName';
  static const dueDateField = 'dueDate';

  User(this.lastLoggedIn, this.maxMoneyPerDay, this.dreamName, this.dueDate);
  
  User.temp(){
    this.lastLoggedIn = DateTime.now();
    this.maxMoneyPerDay = 1;
    this.dreamName = "-";
    this.dueDate = DateTime.now();
  }
  User.fromDb(Map<String, dynamic> json){
    this.maxMoneyPerDay = json[maxMoneyPerDayField];
    this.lastLoggedIn = json[lastLoggendInField].toDate();
    this.dreamName = json[dreamNameField];
    this.dueDate = json[dueDateField].toDate();
  }

  Map<String, dynamic> toJson(){
    return{
      lastLoggendInField: Timestamp.fromDate(this.lastLoggedIn),
      maxMoneyPerDayField: this.maxMoneyPerDay,
      dreamNameField: this.dreamName,
      dueDateField: this.dueDate,
    };
  }
  DateTime lastLoggedIn;
  int maxMoneyPerDay;
  String dreamName;
  DateTime dueDate;

  @override
  String toString() {
    return 'lastLoggedIn: $lastLoggedIn, maxMoneyPerDay: $maxMoneyPerDay, dreamName: $dreamName, dueDate: $dueDate';
  }
}