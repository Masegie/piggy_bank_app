import 'package:dram1y/models/user.dart';
import 'package:dram1y/src/enums/enums.dart';
import 'package:dram1y/src/global_blocs/auth/auth_bloc.dart';
import 'package:dram1y/src/home/pages/deposit_page.dart';
import 'package:dram1y/src/home/pages/money_page.dart';
import 'package:dram1y/src/home/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    MoneyPage(),
    DepositPage(),
    NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          //popup menu untuk logout
          PopupMenuButton(
            onSelected: (value) => onMenuSelection(value,authBloc),
            itemBuilder: (context){
              return[
              const PopupMenuItem<PopupMenuChoices>(
                value: PopupMenuChoices.signOut,
                child: Text('sign out'),
                ),
              ];
            },
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Money'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            title: Text('Notification'),
          ),
        ],
      ),
    );
  }

  void onMenuSelection(PopupMenuChoices value, AuthBloc authBloc){
    if (value == PopupMenuChoices.signOut){
      authBloc.signOut();
    }
  }
}