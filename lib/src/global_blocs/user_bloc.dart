import 'dart:async';

import 'package:dram1y/models/user.dart';
import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/global_blocs/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc implements BlocBase{
  UserBloc();

  User _user;
  StreamSubscription _userStreamSubscription;

  final _userController = BehaviorSubject<User>();
  Function(User) get _inUser => _userController.sink.add;
  Stream<User> get outUser => _userController.stream;

  Future<void> init() async {
    await FirestoreUserService.updateLastLoggedIn();
    final userStream = await FirestoreUserService.getUserStream();
    userStream.listen((doc) {
      _user = User.fromDb(doc.data);
      _inUser(_user);
    });
    //update login terakhir
  }

  @override
  void dispose(){
    _userController.close();
    _userStreamSubscription.cancel();
  }
}