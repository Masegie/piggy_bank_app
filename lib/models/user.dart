import 'package:cloud_firestore/cloud_firestore.dart';


class User{
  static const lastLoggendInField = 'lastLoggedIn';
  static const moneyPerDayField = 'moneyPerDay';
  static const maxMoneyPerDayField = 'maxMoneyPerDay';
  static const dreamNameField = 'dreamName';
  static const dueDateField = 'dueDate';
  static const yourNameField ='yourName';
  static const totalField = 'total';
  static const molaField = 'mola';
 // static const lastDepositField = 'lastDposit';

  User(this.lastLoggedIn, this.maxMoneyPerDay, this.dreamName, this.dueDate, this.yourName, this.total, this.mola,
  );
  
  User.temp(){
    this.lastLoggedIn = DateTime.now();
  //  this.lastDeposit = DateTime.now();
    this.maxMoneyPerDay = 1;
    this.dreamName = "-";
    this.dueDate = DateTime.now();
    this.yourName = "-";
    this.total = 0;
    this.mola = 0;
  }
  User.fromDb(Map<String, dynamic> json){
    this.lastLoggedIn = json[lastLoggendInField].toDate();
    this.maxMoneyPerDay = json[maxMoneyPerDayField];
    this.dreamName = json[dreamNameField];
    this.dueDate = json[dueDateField].toDate();
    this.yourName = json[yourNameField];
    this.total = json[totalField];
    this.mola = json[molaField];
  //  this.lastDeposit = json[lastDepositField];
  }

  Map<String, dynamic> toJson(){
    return{
      lastLoggendInField: Timestamp.fromDate(this.lastLoggedIn),
      maxMoneyPerDayField: this.maxMoneyPerDay,
      dreamNameField: this.dreamName,
      dueDateField: this.dueDate,
      yourNameField: this.yourName,
      totalField: this.total,
      molaField: this.mola,
    //  lastDepositField: this.lastDeposit,
    };
  }
  
  DateTime lastLoggedIn;
  int maxMoneyPerDay;
  String dreamName;
  DateTime dueDate;
  //DateTime lastDeposit;
  String yourName;
  int total;
  int mola;

  @override
  String toString() {
    return 'lastLoggedIn: $lastLoggedIn, maxMoneyPerDay: $maxMoneyPerDay, dreamName: $dreamName, dueDate: $dueDate, yourName: $yourName,total: $total, mola: $mola';
  }
}