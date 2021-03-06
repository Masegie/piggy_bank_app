import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
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
    int temp=0;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StreamBuilder(
            stream: depositBloc.outDepositsAmountTemp ,
            initialData: 0 ,
            builder: (context, snapshot){
              final mol = snapshot.data;
              temp= temp+mol; 
              if (temp<10000){
                return Column(
                  children: <Widget>[
                    SizedBox(height: 30,),
                    Text('Penabung',style: new TextStyle(
                      fontSize: 30,
                      color: Colors.grey.shade700,
                      fontFamily: 'raleway'
                    ),),
                    Text('Tabung sebanyak Rp 10.000',style: new TextStyle(
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
                            child: Image.asset('assets/bintang abu.png',scale: 0.9,),
                          ),
                        ),
                      ),
                    ),
                    Container(
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
                        child: Text('$temp'),
                      ),
                    )
                  ],
                );
              }
              else if (temp < 50000){
                return Column(
                  children: <Widget>[
                    SizedBox(height: 30,),
                    Text('Penabung',style: new TextStyle(
                      fontSize: 30,
                      color: Colors.grey.shade700,
                      fontFamily: 'raleway'
                    ),),
                    Text('Tabung sebanyak Rp 50.000',style: new TextStyle(
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
                            child: Image.asset('assets/bintang merah.png',scale: 0.9,),
                          ),
                        ),
                      ),
                    ),
                    Container(
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
                        child: Text('$temp'),
                      ),
                    )
                  ],
                );
              }
              else if (temp>50000){
                return Column(
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
                    Container(
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
                        child: Text('$temp'),
                      ),
                    )
                  ],
                );
              }
            },
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}