import 'dart:async';
import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/models/temp.dart';
import 'package:dram1y/service/firestore/firestore_deposit_service.dart';
import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/global_blocs/bloc_base.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class DepositBloc implements BlocBase{
  StreamSubscription _depositStreamSubscription;
  StreamSubscription _depositStreamSubscriptionTemp;
  List<Deposit> _depositsToday = List();
  List<DepositTemp> _depositsTodayTemp = List();
  int _selectedDepositAmount = 400;
  int _selectedDepositAmountTemp = 400;

  final DatabaseReference iotDatabase = FirebaseDatabase.instance.reference().child("distance");
  var databaseIot = FirebaseDatabase.instance.reference().child("distance");
   
  final _depositTempController = BehaviorSubject<List<DepositTemp>>();
  Function(List<DepositTemp>) get _inDepositsTemp => _depositTempController.sink.add;
  Stream<List<DepositTemp>> get outDepositsTemp => _depositTempController.stream;

  final _selectedDepositTempAmountController = BehaviorSubject<int>();
  Function(int) get _inSelectedTempAmount => _selectedDepositAmountController.sink.add;
  Stream<int> get outSelectedTempAmount => _selectedDepositAmountController.stream;

  final _depositController = BehaviorSubject<List<Deposit>>();
  Function(List<Deposit>) get _inDeposits => _depositController.sink.add;
  Stream<List<Deposit>> get outDeposits => _depositController.stream;

  final _selectedDepositAmountController = BehaviorSubject<int>();
  Function(int) get _inSelectedAmount => _selectedDepositAmountController.sink.add;
  Stream<int> get outSelectedAmount => _selectedDepositAmountController.stream;

  Stream<int> get outDepositsAmount {
    return outDeposits.map(
      (deposits) => deposits.fold<int>(0, (totalAmount, deposit) => totalAmount + deposit.amount)
    );
  }

  Stream<int> get outDepositsAmountTemp {
    return outDepositsTemp.map(
      (deposits) => deposits.fold<int>(0, (totalAmount, deposit) => totalAmount + deposit.amount)
    );
  }

  Future<void> init() async {
    final depositStream = await FirestoreDepositService.getDepositStream(DateTime.now());
    final depositStreamTemp = await FirestoreDepositService.getDepositStream(DateTime.now());
    _depositStreamSubscriptionTemp = depositStream.listen((querySnapshot) {
      _depositsToday = querySnapshot.documents.map((doc) => Deposit.fromDb(doc.data,doc.documentID)).toList();
      _inDeposits(_depositsToday);
    });

    _depositStreamSubscription = depositStreamTemp.listen((querySnapshot) {
      _depositsTodayTemp = querySnapshot.documents.map((doc) => DepositTemp.fromDb(doc.data,doc.documentID)).toList();
      _inDepositsTemp(_depositsTodayTemp);
    });

    _inSelectedAmount(_selectedDepositAmount);
    _inSelectedTempAmount(_selectedDepositAmount);
  }

  Future<void> depositMoney() async {
    final deposit = Deposit(DateTime.now(), _selectedDepositAmount);
    final depositTemp = DepositTemp(DateTime.now(), _selectedDepositAmountTemp);
    FirestoreDepositService.depositMoney(deposit);
    FirestoreDepositService.depositTempMoney(depositTemp);
    FirestoreUserService.updateTotal(_selectedDepositAmount,deposit.amount);
   // FirestoreUserService.updateLastDeposit();
    iotDatabase.set(100);
  }

  Future<void> resetDepositMoney() async {
    final deposit = Deposit(DateTime.now(), (_selectedDepositAmount*0));
    FirestoreDepositService.depositMoney(deposit);
  }

  Future<void> removeDeposit(Deposit deposit) async {
    FirestoreDepositService.removeDeposit(deposit);
  }

  Future<void> removeDepositTemp(DepositTemp deposits) async {
    FirestoreDepositService.removeDepositTemp(deposits);
  }

   Future<void> removeCollection() async {
    FirestoreDepositService.removeCollection();
  }

  set setDepositAmount(int amount) {
    _selectedDepositAmount = amount;
    _inSelectedAmount(_selectedDepositAmount);
  }

  @override
  void dispose(){
    _depositController.close();
    _depositTempController.close();
    _selectedDepositAmountController.close();
    _selectedDepositTempAmountController.close();
    _depositStreamSubscription.cancel();
  }
}
