import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardDreamTargetPopup extends StatefulWidget {
  @override
  _RewardDreamTargetPopupState createState() => _RewardDreamTargetPopupState();
}

class _RewardDreamTargetPopupState extends State<RewardDreamTargetPopup> {
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StreamBuilder(
            stream: userBloc.outMola ,
            initialData: 1 ,
            builder: (context, snapshot){
              final mol = snapshot.data;
              if(mol <5 ){
                return Column(children: <Widget>[
                SizedBox(height: 30,),
                Text('Pemimpi',style: new TextStyle(
                  fontSize: 30,
                  color: Colors.grey.shade700,
                  fontFamily: 'raleway'
                  ),),
                  Text('Selesaikan 5 mimpi',style: new TextStyle(
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
                      child: Text('$mol'),
                    ),
                  )
                ],);
              }
              else if (mol < 10)
              {
                return Column(children: <Widget>[
                SizedBox(height: 30,),
                Text('Pemimpi',style: new TextStyle(
                  fontSize: 30,
                  color: Colors.grey.shade700,
                  fontFamily: 'raleway'
                  ),),
                  Text('Selesaikan 10 mimpi',style: new TextStyle(
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
                      child: Text('$mol'),
                    ),
                  )
                ],);
              }
              else if (mol >=10)
              {
                return Column(children: <Widget>[
                SizedBox(height: 30,),
                Text('Pemimpi',style: new TextStyle(
                  fontSize: 30,
                  color: Colors.grey.shade700,
                  fontFamily: 'raleway'
                  ),),
                  Text('Selesaikan 50 mimpi',style: new TextStyle(
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
                      child: Text('$mol'),
                    ),
                  )
                ],);
              }
            },
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}