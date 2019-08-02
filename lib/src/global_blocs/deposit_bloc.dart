import 'dart:async';
import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/service/firestore/firestore_deposit_service.dart';
import 'package:dram1y/src/global_blocs/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class DepositBloc implements BlocBase{
  StreamSubscription _depositStreamSubscription;
  List<Deposit> _depositsToday = List();
  int _selectedMoneyAmount = 400;

  final _depositController = BehaviorSubject<List<Deposit>>();
  Function(List<Deposit>) get _inDeposits => _depositController.sink.add;
  Stream<List<Deposit>> get outDeposits => _depositController.stream;

  final _selectedDepositAmountController = BehaviorSubject<int>();
  Function(int) get _inSelectedAmount => _selectedDepositAmountController.sink.add;
  Stream<int> get outSelectedAmount => _selectedDepositAmountController.stream;

   Stream<int> get outDepositsAmount {
    return outDeposits.map((deposits) => deposits.fold<int>(0, (totalAmount, deposit) => totalAmount + deposit.amount));
  }

  Future<void> init() async {
    final depositStream = await FirestoreDepositService.getDepositStream(DateTime.now());
    _depositStreamSubscription = depositStream.listen((querySnapshot) {
      _depositsToday = querySnapshot.documents.map((doc) => Deposit.fromDb(doc.data,doc.documentID)).toList();
      _inDeposits(_depositsToday);
    });

    _inSelectedAmount(_selectedMoneyAmount);
  }

  Future<void> depositMoney() async {
    final deposit = Deposit(DateTime.now(), _selectedMoneyAmount);
    FirestoreDepositService.depositMoney(deposit);
  }

  Future<void> removeDeposit(Deposit deposit) async {
    FirestoreDepositService.removeDeposit(deposit);
  }

  set setDepositAmount(int amount) {
    _selectedMoneyAmount = amount;
    _inSelectedAmount(_selectedMoneyAmount);
  }

  @override
  void dispose(){
    _depositController.close();
    _selectedDepositAmountController.close();
    _depositStreamSubscription.cancel();
  }
}
