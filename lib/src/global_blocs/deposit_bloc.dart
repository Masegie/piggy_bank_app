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

  //  Stream<int> get outDepositsAmount {
  //   return outDeposits.map((deposits) => deposits.fold<int>(0, (totalAmount, deposit) => totalAmount + deposit.amount));
  // }

  Stream<int> get outDepositsAmount => outDeposits.map((deposits){
    int totalValue=0;
    for(Deposit deposit in deposits) {
      totalValue += deposit.amount;
    }
    return totalValue;
  });

  Future<void> init() async {
    final depositStream = await FirestoreDepositService.getDepositStream(DateTime.now());
    _depositStreamSubscription = depositStream.listen((querySnapshot) {
      _depositsToday = querySnapshot.documents.map((doc) => Deposit.fromDb(doc.data)).toList();
      _inDeposits(_depositsToday);
    });
  }

  Future<void> depositMoney() async {
    final deposit = Deposit(DateTime.now(), _selectedMoneyAmount);
    FirestoreDepositService.depositMoney(deposit);
  }

  @override
  void dispose(){
    _depositController.close();
    _depositStreamSubscription.cancel();
  }
}