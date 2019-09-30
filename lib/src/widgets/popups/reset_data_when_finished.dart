import 'package:dram1y/service/firestore/firestore_user_service.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/home/home_page_setup.dart';
import 'package:dram1y/src/home/pages/history_page.dart';
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
                smallSpace,
                Text(
                  'Mimpimu Telat Tercapai!',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontFamily: 'Raleway',fontSize: 25,fontWeight: FontWeight.bold,
                  ),
                ),
                smallSpace,smallSpace,smallSpace,
                Image.asset('assets/selamat.png',scale: 2,),
                largeSpace,
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    child: Text('Apakah kamu mau membuat mimpi lagi ?',
                    style: new TextStyle(
                    fontFamily: 'Raleway',fontSize: 16,
                  ),),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HistoryPage(),
                    )
                  );
                }, 
                child: Text('Buat Lagi !',
                style: new TextStyle(
                    fontFamily: 'Raleway',fontWeight: FontWeight.bold,color: Colors.white
                  ),),
                color: Colors.green.shade200,
              ),
              SizedBox(width: 30,),
              FlatButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePageSetup(),
                    )
                  );
                }, 
                child: Text('Tidak',style: new TextStyle(
                    fontFamily: 'Raleway',fontWeight: FontWeight.bold,color: Colors.white
                  ),),
                color: Colors.red.shade200,
              ),
            ],
          ),
          largeSpace,
        ],
      ),
    );
  }

  Widget get largeSpace => SizedBox(height: 24);
  Widget get smallSpace => SizedBox(height: 12);

  void resetAmount(DepositBloc depositBloc) {
    depositBloc.setDepositAmount = 0;
  }
}