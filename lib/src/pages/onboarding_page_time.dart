import 'package:dram1y/src/global_blocs/app_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/pages/onboarding_page.dart';
import 'package:dram1y/src/widgets/popups/custom_dream_onboarding_popup.dart';
import 'package:flutter/material.dart';
import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/widgets/custom_wide_flat_button.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OnboardingTimePage extends StatefulWidget {
  @override
  _OnboardingTimePageState createState() => _OnboardingTimePageState();
}

class _OnboardingTimePageState extends State<OnboardingTimePage> {
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<AppBloc>(context).userBloc;
    final textTheme = Theme.of(context).textTheme;
    String formatDate = new DateFormat.yMMMd().format(selectedTime);
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
                    onPressed: selectTime,
                     child: Text(
                      '$formatDate',
                      style: TextStyle(fontFamily: 'Raleway',fontSize: 17),
                    ),
                  ),bigTextSpace,
                  CustomWideFlatButton(
                    backgroundColor: Colors.green.shade300,
                    foregroundColor: Colors.white,
                    isRoundedAtBottom: false,
                    text: 'Next',
                    onPressed: () async {
                      await FirestoreUserService.updateDueDate(selectedTime);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => OnboardingPage(),
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
      'Set your due date!',
      style: textTheme.subtitle.copyWith(
        fontFamily: 'Raleway',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green
      ),
    );
  }

  Future<void> selectTime() async {
    final time = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void createNotification(UserBloc userBloc) {
    final dueDate = selectedTime;
    userBloc.setDueDate(dueDate);
    Navigator.of(context).pop(dueDate);
    
  }
}