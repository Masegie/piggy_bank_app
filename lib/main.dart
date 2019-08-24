import 'package:dram1y/src/global_blocs/app_bloc.dart';
import 'package:dram1y/src/global_blocs/auth/auth_bloc.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/notification_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/root_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(Dreamoney());

class Dreamoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBloc>(
          builder: (_) => AuthBloc(),
        ),
        Provider<UserBloc>(
          builder: (_) => UserBloc(),
          dispose: (_, userBloc) => userBloc.dispose(),  
        ),
        Provider<AppBloc>(
          builder: (_) => AppBloc(),
          dispose: (_, appBloc) => appBloc.dispose(),
        ),
        Provider<DepositBloc>(
          builder: (_) => DepositBloc(),
          dispose: (_, depositBloc) => depositBloc.dispose(),  
        ),
        Provider<NotificationBloc>(
          builder: (_) => NotificationBloc(),
          dispose: (_, notificationBloc) => notificationBloc.dispose(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Teman Menabungku',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(),
      ),
    );
  }
}