import 'package:cloud_firestore/cloud_firestore.dart';


class User{
  static const lastLoggendInField = 'lastLoggedIn';
  static const moneyPerDayField = 'moneyPerDay';
  static const maxMoneyPerDayField = 'maxMoneyPerDay';
  static const dreamNameField = 'dreamName';
  static const dueDateField = 'dueDate';
  static const yourNameField ='yourName';

  User(this.lastLoggedIn, this.maxMoneyPerDay, this.dreamName, this.dueDate, this.yourName);
  
  User.temp(){
    this.lastLoggedIn = DateTime.now();
    this.maxMoneyPerDay = 1;
    this.dreamName = "-";
    this.dueDate = DateTime.now();
    this.yourName = "-";
  }
  User.fromDb(Map<String, dynamic> json){
    this.maxMoneyPerDay = json[maxMoneyPerDayField];
    this.lastLoggedIn = json[lastLoggendInField].toDate();
    this.dreamName = json[dreamNameField];
    this.dueDate = json[dueDateField].toDate();
    this.yourName = json[yourNameField];
  }

  Map<String, dynamic> toJson(){
    return{
      lastLoggendInField: Timestamp.fromDate(this.lastLoggedIn),
      maxMoneyPerDayField: this.maxMoneyPerDay,
      dreamNameField: this.dreamName,
      dueDateField: this.dueDate,
      yourNameField: this.yourName,
    };
  }
  DateTime lastLoggedIn;
  int maxMoneyPerDay;
  String dreamName;
  DateTime dueDate;
  String yourName;

  @override
  String toString() {
    return 'lastLoggedIn: $lastLoggedIn, maxMoneyPerDay: $maxMoneyPerDay, dreamName: $dreamName, dueDate: $dueDate, yourName: $yourName';
  }
}