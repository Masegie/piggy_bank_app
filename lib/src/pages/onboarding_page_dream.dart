import 'package:dram1y/src/pages/onboarding_page.dart';
import 'package:dram1y/src/pages/onboarding_page_time.dart';
import 'package:dram1y/src/widgets/popups/custom_dream_onboarding_popup.dart';
import 'package:flutter/material.dart';
import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/widgets/custom_wide_flat_button.dart';

class OnboardingDreamPage extends StatefulWidget {
  @override
  _OnboardingDreamPageState createState() => _OnboardingDreamPageState();
}

class _OnboardingDreamPageState extends State<OnboardingDreamPage> {
  String selectedName = 'Membeli Mac Book Pro';

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
                      String name = await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return CustomDreamOnboardingPopup();
                        }
                      );
                      setState(() => selectedName = name);
                    },
                    child: Text(
                      '$selectedName',
                      style: textTheme.title,
                    ),
                  ),
                ],
              ),
            ),
            CustomWideFlatButton(
              backgroundColor: Colors.blue.shade300,
              foregroundColor: Colors.blue.shade900,
              isRoundedAtBottom: false,
              text: 'Next',
              onPressed: () async {
                await FirestoreUserService.updateDreamName(selectedName);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => OnboardingTimePage(),
                  )
                );
              },
            )
          ],
        ),
      ),
    );
  }
  Widget get smallTextSpace => SizedBox(height: 8);
  Widget get bigTextSpace => SizedBox(height: 58);
  
  Text title(TextTheme textTheme) {
    return Text(
      "Let's start reaching your dreams!",
      style: textTheme.title.copyWith(
        fontSize: 24,
      ),
    );
  }

  Text subTitle(TextTheme textTheme) {
    return Text(
      'Set your dream name!',
      style: textTheme.subtitle.copyWith(
        fontSize: 20,
      ),
    );
  }
}