import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/models/user.dart';
import 'package:dram1y/service/firestore/firestore_deposit_service.dart';
import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/global_blocs/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class DepositBloc implements BlocBase{
  StreamSubscription _depositStreamSubscription;
  List<Deposit> _depositsToday = List();

  final _depositController = BehaviorSubject<List<Deposit>>();
  Function(List<Deposit>) get _inDeposits => _depositController.sink.add;
  Stream<List<Deposit>> get outDeposits => _depositController.stream;

  Stream<int> get outDepositsAmount => outDeposits.map((deposits){
    int totalValue=0;
    for(Deposit deposit in deposits) {
      totalValue += deposit.amount;
    }
  });

  Future<void> init() async {
    final depositStream = await FirestoreDepositService.getDepositStream(DateTime.now());
    _depositStreamSubscription = depositStream.listen((querySnapshot) {
      _depositsToday = querySnapshot.documents.map((doc) => Deposit.fromDb(doc.data)).toList();
      _inDeposits(_depositsToday);
    });
  }

  @override
  void dispose(){
    _depositController.close();
    _depositStreamSubscription.cancel();
  }
}