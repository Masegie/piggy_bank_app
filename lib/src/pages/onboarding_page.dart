import 'package:dram1y/src/pages/onboarding_page_dream.dart';
import 'package:dram1y/src/widgets/popups/custom_amount_onboarding_popup.dart';
import 'package:flutter/material.dart';
import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/root_page.dart';
import 'package:dram1y/src/widgets/custom_wide_flat_button.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int selectedAmount = 2500;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100, width: double.infinity),
            smallTextSpace,
            title(textTheme),
            bigTextSpace,
            subTitle(textTheme),
            smallTextSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  OutlineButton(
                    padding: const EdgeInsets.symmetric(horizontal: 42,vertical: 16),
                    onPressed: () async {
                      int amount = await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return CustomAmountOnboardingPopup();
                        }
                      );
                      setState(() => selectedAmount = amount);
                    },
                    child: Text(
                      'Rp. $selectedAmount',
                      style: TextStyle(fontFamily: 'Raleway',fontSize: 17),
                    ),
                  ),bigTextSpace,
                  CustomWideFlatButton(
                    backgroundColor: Colors.green.shade300,
                    foregroundColor: Colors.white,
                    isRoundedAtBottom: false,
                    text: "Let's Start !",
                    onPressed: () async {
                      await FirestoreUserService.updateTotalMoney(selectedAmount);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => RootPage(),
                        )
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget get smallTextSpace => SizedBox(height: 20);
  Widget get bigTextSpace => SizedBox(height: 58);
  
  Text title(TextTheme textTheme) {
    return Text(
      "Let's start reaching your dreams!",
      style: textTheme.title.copyWith(
        fontFamily: 'Raleway',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.green
      ),
    );
  }

  Text subTitle(TextTheme textTheme) {
    return Text(
      'Set your dream goal!',
      style: textTheme.subtitle.copyWith(
        fontFamily: 'Raleway',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green
      ),
    );
  }
}