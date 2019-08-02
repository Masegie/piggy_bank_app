import 'package:dram1y/models/user.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/home/page_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageSetup extends StatefulWidget {
  @override
  _HomePageSetupState createState() => _HomePageSetupState();
}

class _HomePageSetupState extends State<HomePageSetup> {
 
  @override
  void initState() {
    super.initState();
    // cek dan buat user
    // inisiasi bloc
    Future.delayed(Duration.zero, () async {
        final userBloc = Provider.of<UserBloc>(context);
        final depositBloc = Provider.of<DepositBloc>(context);
        await userBloc.init();
        await depositBloc.init();
      }
    );
  }
 
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    return StreamBuilder<User>(
      stream: userBloc.outUser,
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text(
                snapshot.error.toString()
              )
            )
          );
        }
        else if (snapshot.hasData) {
          final user = snapshot.data;
          return PageContainer(user: user);
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          )
        );
      },
    );
  }
}