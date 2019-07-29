import 'package:dram1y/src/global_blocs/auth/auth_bloc.dart';
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
        )
      ],
      child: MaterialApp(
        title: 'Teman Menabungku',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(),
      ),
    );
  }
}