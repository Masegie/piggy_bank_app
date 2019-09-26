import 'package:dram1y/src/login/login_page.dart';
import 'package:dram1y/src/pages/onboarding_page_time.dart';
import 'package:dram1y/src/widgets/popups/custom_dream_onboarding_popup.dart';
import 'package:flutter/material.dart';
import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/widgets/custom_wide_flat_button.dart';
int i =1;
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
      backgroundColor: Colors.white,
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
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
                    color: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 16),
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
                      style: TextStyle(fontFamily: 'Raleway',fontSize: 17),
                    ),
                  ),bigTextSpace,
                  CustomWideFlatButton(
                    backgroundColor: Colors.green.shade300,
                    foregroundColor: Colors.white,
                    isRoundedAtBottom: false,
                    onPressed: () async {
                      await FirestoreUserService.updateDreamName(selectedName);
                      await FirestoreUserService.updateMola(i++);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => OnboardingTimePage(),
                        )
                      );
                    },
                  ), FlatButton(
                      child: Text("asd"),
                      onPressed: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        )
                      );
                    }
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
      style: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.green
      ),
    );
  }

  Text subTitle(TextTheme textTheme) {
    return Text(
      'Set your dream name!',
      style: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green
      ),
    );
  }
}