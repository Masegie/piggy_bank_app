import 'package:dram1y/models/user.dart';
import 'package:dram1y/src/enums/enums.dart';
import 'package:dram1y/src/global_blocs/auth/auth_bloc.dart';
import 'package:dram1y/src/home/pages/home_page.dart';
import 'package:dram1y/src/home/pages/money_page.dart';
import 'package:dram1y/src/home/pages/notification_page.dart';
import 'package:dram1y/src/widgets/popups/sync_account_popup.dart';
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

  bool isAnonymous = false;
  AuthBloc auth;
  
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          //popup menu
          PopupMenuButton(
            onSelected: (value) => onMenuSelection(value,authBloc),
            itemBuilder: (context){
              return[
              const PopupMenuItem<PopupMenuChoices>(
                value: PopupMenuChoices.signOut,
                child: Text('sign out'),
                ),
               if (isAnonymous)
                const PopupMenuItem<PopupMenuChoices>(
                  value: PopupMenuChoices.syncPopup,
                  child: Text('sync account'),
                )
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

  void onMenuSelection(PopupMenuChoices value, AuthBloc auth) async {
    switch (value) {
      case PopupMenuChoices.signOut:
        auth.signOut();
        break;
      case PopupMenuChoices.syncPopup:
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return SyncAccountPopup();
          },
        );
        final firebaseUser = await auth.currentUser();
        setState(() {
          isAnonymous = firebaseUser.isAnonymous;
        });
        break;
      default:
    }
  }
}
