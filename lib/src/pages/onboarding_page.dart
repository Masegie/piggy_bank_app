import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/pages/onboarding_page_time.dart';
import 'package:dram1y/src/widgets/popups/custom_amount_onboarding_popup.dart';
import 'package:flutter/material.dart';
import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/root_page.dart';
import 'package:dram1y/src/widgets/custom_wide_flat_button.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}
 int a = 1;
class _OnboardingPageState extends State<OnboardingPage> {
  int selectedAmount = 2500;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final depositBloc = Provider.of<DepositBloc>(context);
    final userBloc = Provider.of<UserBloc>(context);
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100, width: double.infinity),
            smallTextSpace,
            Image.asset('assets/price_mochi.png',scale: 2,),
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
                  ),smallTextSpace,
                  CustomWideFlatButton(
                    backgroundColor: Colors.green[200],
                    foregroundColor: Colors.white,
                    isRoundedAtBottom: false,
                    text: "Ayo Mulai !",
                    onPressed: () async {
                      await FirestoreUserService.updateTotalMoney(selectedAmount);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => RootPage(),
                        )
                      );
                    },
                  ),
                  FlatButton(
                      child: Text("kembali"),
                      onPressed: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => OnboardingTimePage(),
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
      "Berapa Harganya ?",
      style: textTheme.title.copyWith(
        fontFamily: 'Raleway',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade600
      ),
    );
  }

  Text subTitle(TextTheme textTheme) {
    return Text(
      'Klik box dibawah untuk memasukan harganya',
      style: textTheme.subtitle.copyWith(
        fontFamily: 'Raleway',
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade400
      ),
    );
  }
}