import 'package:dram1y/src/global_blocs/auth/auth_bloc.dart';
import 'package:dram1y/src/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home_page_setup.dart';
 
 // Tampil hompage
 // atau tampil login page 
class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBloc>(context);
    return StreamBuilder<FirebaseUser>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return new HomePageSetup();
        }
        return LoginPage();
      },
    );
  }
}

