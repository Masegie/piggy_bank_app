import 'package:dram1y/src/global_blocs/bloc_base.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/notification_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';

class AppBloc implements BlocBase {
  UserBloc _userBloc;
  DepositBloc _depositBloc;
  NotificationBloc _notificationBloc;

  AppBloc() {
    _userBloc = UserBloc();
    _depositBloc = DepositBloc();
    _notificationBloc = NotificationBloc();
  }

  Future<void> init() async {
    await _userBloc.init();
    await _depositBloc.init();
    await _notificationBloc.init();
  }

  UserBloc get userBloc => _userBloc;
  DepositBloc get depositBloc => _depositBloc;
  NotificationBloc get notificationBloc => _notificationBloc;

  @override
  void dispose() {
    _userBloc.dispose();
    _depositBloc.dispose();
    _notificationBloc.dispose();
  }
}