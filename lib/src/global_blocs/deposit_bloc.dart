import 'dart:async';
import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/service/firestore/firestore_deposit_service.dart';
import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/global_blocs/bloc_base.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class DepositBloc implements BlocBase{
  StreamSubscription _depositStreamSubscription;
  List<Deposit> _depositsToday = List();
  int _selectedDepositAmount = 400;
  final DatabaseReference iotDatabase = FirebaseDatabase.instance.reference().child("distance");
  var databaseIot = FirebaseDatabase.instance.reference().child("distance");
   

  final _depositController = BehaviorSubject<List<Deposit>>();
  Function(List<Deposit>) get _inDeposits => _depositController.sink.add;
  Stream<List<Deposit>> get outDeposits => _depositController.stream;

  final _selectedDepositAmountController = BehaviorSubject<int>();
  Function(int) get _inSelectedAmount => _selectedDepositAmountController.sink.add;
  Stream<int> get outSelectedAmount => _selectedDepositAmountController.stream;

  Stream<int> get outDepositsAmount {
    return outDeposits.map((deposits) => deposits.fold<int>(0, (totalAmount, deposit) => totalAmount + deposit.amount));
  }

  Stream<int> get outDepositsAmountTemp {
    return outDeposits.map((deposits) => deposits.fold<int>(0, (totalAmount, deposit) => totalAmount + deposit.amount));
  }

  Future<void> init() async {
    final depositStream = await FirestoreDepositService.getDepositStream(DateTime.now());
    _depositStreamSubscription = depositStream.listen((querySnapshot) {
      _depositsToday = querySnapshot.documents.map((doc) => Deposit.fromDb(doc.data,doc.documentID)).toList();
      _inDeposits(_depositsToday);
    });

    _inSelectedAmount(_selectedDepositAmount);
  }

  Future<void> depositMoney() async {
    final deposit = Deposit(DateTime.now(), _selectedDepositAmount);
    FirestoreDepositService.depositMoney(deposit);
    FirestoreUserService.updateTotal(_selectedDepositAmount,deposit.amount);
    iotDatabase.set(100);
  }

  Future<void> resetDepositMoney() async {
    final deposit = Deposit(DateTime.now(), (_selectedDepositAmount*0));
    FirestoreDepositService.depositMoney(deposit);
  }

  Future<void> removeDeposit(Deposit deposit) async {
    FirestoreDepositService.removeDeposit(deposit);
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
    _selectedDepositAmountController.close();
    _depositStreamSubscription.cancel();
  }
}
