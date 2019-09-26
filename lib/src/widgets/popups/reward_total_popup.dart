import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/widgets/buttons/custom_wide_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardTotalTargetPopup extends StatefulWidget {
  @override
  _RewardTotalTargetPopupState createState() => _RewardTotalTargetPopupState();
}

class _RewardTotalTargetPopupState extends State<RewardTotalTargetPopup> {
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    final depositBloc = Provider.of<DepositBloc>(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 30,),
          Text('Penabung',style: new TextStyle(
            fontSize: 30,
            color: Colors.grey.shade700,
            fontFamily: 'raleway'
          ),),
          Text('Tabung sebanyak Rp 100.000',style: new TextStyle(
            fontSize: 20,
            color: Colors.grey.shade700,
            fontFamily: 'raleway'
          ),),
          SizedBox(height: 30,),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.yellow.shade300,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(100.0),
                topLeft: Radius.circular(100.0),
                bottomLeft: Radius.circular(100.0),
                bottomRight: Radius.circular(100.0),
              ),
            ),
            child: Center(
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100.0),
                    topLeft: Radius.circular(100.0),
                    bottomLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0),
                  ),
                ),
                child: Center(
                  child: Image.asset('assets/bintang.png',scale: 0.9,),
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: userBloc.outTotal ,
            initialData: 1 ,
            builder: (context, snapshot){
              final mol = snapshot.data;
              return Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade300,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100.0),
                    topLeft: Radius.circular(100.0),
                    bottomLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0),
                  ),
                ),
                child: Center(
                  child: Text('$mol'),
                ),
              );
            },
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}