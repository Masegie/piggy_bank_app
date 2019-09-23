import 'dart:async' show Future, Stream, StreamSubscription;
import 'package:dram1y/models/user.dart';
import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/global_blocs/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc implements BlocBase{
  UserBloc();

  User _user;
  StreamSubscription _userStreamSubscription;
  String _selectedDreamName = "duno";
  DateTime _selectedDueDate = DateTime.now();
  String _selectedYourName = "duno";
  int _selectedTotal = 100;

  final _userController = BehaviorSubject<User>();
  Function(User) get _inUser => _userController.sink.add;
  Stream<User> get outUser => _userController.stream;

  final _selectedDreamNameController = BehaviorSubject<String>();
  Function(String) get _inSelectedName => _selectedDreamNameController.sink.add;
  Stream<String> get outSelectedName => _selectedDreamNameController.stream;

  final _selectedYourNameController = BehaviorSubject<String>();
  Function(String) get _inSelectedYourName => _selectedYourNameController.sink.add;
  Stream<String> get outSelectedYourName => _selectedYourNameController.stream;

  final _selectedDueDateController = BehaviorSubject<DateTime>();
  Function(DateTime) get _inSelectedDueDate => _selectedDueDateController.sink.add;
  Stream<DateTime> get outSelectedDueDate => _selectedDueDateController.stream;

  Stream<int> get outTotal => outUser.map((user) => user.total);

  Stream<int> get outMola => outUser.map((user) => user.mola);

  Stream<int> get outMaxMoney => outUser.map((user) => user.maxMoneyPerDay);

  Stream<String> get outDreamName => outUser.map((user) => user.dreamName);

  Stream<String> get outYourName => outUser.map((user) => user.yourName);

  Stream<DateTime> get outDueDate => outUser.map((user) => user.dueDate);

  Future<void> init() async {
    await FirestoreUserService.checkAndCreateUser();
    await FirestoreUserService.updateLastLoggedIn();
    final userStream = await FirestoreUserService.getUserStream();
    _userStreamSubscription = userStream.listen((doc) {
      _user = User.fromDb(doc.data);
      _inUser(_user);
    });
    //update login terakhir
    _inSelectedName(_selectedDreamName);
    //_inSelectedDueDate(_selectedDueDate);
  }

  setDreamName(String name) {
    _selectedDreamName = name;
    _inSelectedName(_selectedDreamName);
  }

  setYourName(String name) {
    _selectedYourName = name;
    _inSelectedYourName(_selectedYourName);
  }

  setDueDate(DateTime dueDate) {
    _selectedDueDate = dueDate;
    _inSelectedDueDate(_selectedDueDate);
  }

  @override
  void dispose(){
    _userController.close();
    _selectedDreamNameController.close();
    _selectedYourNameController.close();
    _selectedDueDateController.close();
    _userStreamSubscription.cancel();
  }
}
