import 'package:dram1y/src/widgets/buttons/anonymousSignInButton.dart';
import 'package:dram1y/src/widgets/buttons/googleSignInButton.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
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
                GoogleSignInButton(),
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
    );
  }

  Widget get textSpace => SizedBox(height: 8);

  SizedBox appIcon(){
    return SizedBox(
          height: 150,
          width: 150,
          child: Placeholder(),
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

