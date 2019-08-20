import 'package:dram1y/src/global_blocs/auth/auth_bloc.dart';
import 'package:dram1y/src/widgets/buttons/anonymousSignInButton.dart';
import 'package:dram1y/src/widgets/buttons/googleSignInButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final auth = Provider.of<AuthBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100,width: double.infinity),
            appIcon(),
            textSpace,
            title(textTheme),
            textSpace,
            subTitle(textTheme),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GoogleSignInButton(
                    onPressed: auth.signInWithGoogle,
                  ),
                  AnonymousSignInButton(),
                ],
              ),
            ),
            Text(
              'By creating an account, you are agreeing to our\nTerms of Service and Privacy Policy',
              textAlign: TextAlign.center,
              ),
              textSpace,
          ],
        ),
      ),
    );
  }

  Widget get textSpace => SizedBox(height: 8);

  Widget appIcon(){
    return Image.asset(
      'assets/sign_in_icon.png',
      width: 125,
      height: 125,
    );
  }

  Text title(TextTheme textTheme) {
    return Text(
          'Dreamoney',
          style: textTheme.title.copyWith(
            fontSize: 24
          ),
        );
  }

  Text subTitle(TextTheme textTheme) {
    return Text(
          'Teman Menabung Yang Asik',
          style: textTheme.title.copyWith(
            fontSize: 18
          ),
        );
  }
}

