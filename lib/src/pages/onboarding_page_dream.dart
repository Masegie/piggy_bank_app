import 'package:dram1y/src/login/login_page.dart';
import 'package:dram1y/src/pages/onboarding_page_name.dart';
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
                Image.asset('assets/dream_mochi.png',scale: 2,),
                bigTextSpace,
                title(textTheme),
                smallTextSpace,
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
                  ),smallTextSpace,
                  CustomWideFlatButton(
                    backgroundColor: Colors.green[200],
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
                      child: Text("kembali"),
                      onPressed: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => OnboardingNamePage(),
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
      "Apa Mimpimu ?",
      style: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade600
      ),
    );
  }

  Text subTitle(TextTheme textTheme) {
    return Text(
      'Masukan apa yang kamu inginkan kedalam kotak di bawah.',
      style: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade400
      ),
    );
  }
}