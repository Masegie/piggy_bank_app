import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/pages/onboarding_page_dream.dart';
import 'package:flutter/material.dart';

class ResetDataWhenFinished extends StatefulWidget {
  @override
  _ResetDataWhenFinishedState createState() => _ResetDataWhenFinishedState();
}

class _ResetDataWhenFinishedState extends State<ResetDataWhenFinished> {
  final DateTime resetDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18, left: 12, right: 12),
            child: Column(
              children: <Widget>[
                Text(
                  'Congrats!',
                  style: Theme.of(context).textTheme.title.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                ),
                smallSpace,
                Text(
                  ' Your Goal has been reached',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle.copyWith(),
                ),
                smallSpace,
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    child: Text('Klik this to reset your dream and pick up your money'),
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            onPressed: () async {
              await FirestoreUserService.updateDreamName('null');
              await FirestoreUserService.updateDueDate(resetDate);
              await FirestoreUserService.updateTotalMoney(0);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => OnboardingDreamPage(),
                )
              );
            }, 
            child: Text('Reset'),
            color: Colors.blue.shade300,
          ),
          smallSpace,
        ],
      ),
    );
  }

  Widget get largeSpace => SizedBox(height: 24);
  Widget get smallSpace => SizedBox(height: 12);
}