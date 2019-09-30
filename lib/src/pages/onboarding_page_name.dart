import 'package:dram1y/src/login/login_page.dart';
import 'package:dram1y/src/pages/onboarding_page_dream.dart';
import 'package:dram1y/src/widgets/popups/custom_name_onboarding_popup.dart';
import 'package:flutter/material.dart';
import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/widgets/custom_wide_flat_button.dart';

class OnboardingNamePage extends StatefulWidget {
  @override
  _OnboardingNamePageState createState() => _OnboardingNamePageState();
}

class _OnboardingNamePageState extends State<OnboardingNamePage> {
  String selectedNamez = 'Namamu Siapa';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100, width: double.infinity),
                Image.asset('assets/welcome_mochi.png',scale: 2,),
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
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                        color: Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 16),
                        onPressed: () async {
                          String name = await showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return CustomNameOnboardingPopups();
                            }
                          );
                          setState(() => selectedNamez = name);
                        },
                        child: Text(
                          '$selectedNamez',
                          style: TextStyle(fontFamily: 'Raleway',fontSize: 17),
                        ),
                      ),smallTextSpace,
                      CustomWideFlatButton(
                        backgroundColor: Colors.green[200],
                        foregroundColor: Colors.white,
                        isRoundedAtBottom: false,
                        onPressed: () async {
                          await FirestoreUserService.updateYourName(selectedNamez);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => OnboardingDreamPage(),
                            )
                          );
                        },
                      ),
                      FlatButton(
                      child: Text("kembali"),
                      onPressed: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        )
                      );
                    }
                  )

                      // FlatButton(
                      //     child: Text("asd"),
                      //     onPressed: () async {
                      //     Navigator.of(context).pushReplacement(
                      //       MaterialPageRoute(
                      //         builder: (context) => LoginPage(),
                      //       )
                      //     );
                      //   }
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
  Widget get verysmallTextSpace => SizedBox(height: 10);
  Widget get smallTextSpace => SizedBox(height: 20);
  Widget get bigTextSpace => SizedBox(height: 58);
  
  Text title(TextTheme textTheme) {
    return Text(
      "Siapa Namamu ?",
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
      'Klik box dibawah untuk memasukan nama anda',
      style: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade400
      ),
    );
  }
}