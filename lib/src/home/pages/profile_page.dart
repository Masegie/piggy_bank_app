import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/root_page.dart';
import 'package:dram1y/src/widgets/popups/reward_dream_target_popup.dart';
import 'package:dram1y/src/widgets/popups/reward_total_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
int total = 0;
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    final depositBloc = Provider.of<DepositBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
        ),
        title: const Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () async {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => RootPage(),
              )
            );
          } 
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            StreamBuilder<String>(
              stream: userBloc.outYourName,
              initialData: '1',
              builder: (context , snapshot) {
                final name = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0),
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0)
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                    Text("$name",
                      style: new TextStyle(
                        fontSize: 40,
                        color: Colors.green.shade300,
                        fontFamily: 'Raleway'
                      ),
                    ),SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 481,
                      decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0)
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Statistik Profilmu",
                            style: new TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontFamily: 'Raleway'
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 5,),
                              Text("Total Menabung :",
                                style: new TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontFamily: 'Raleway'
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 5,),
                              StreamBuilder<int>(
                                stream: userBloc.outTotal,
                                initialData: 0,
                                builder: (context,snapshot){
                                  final total = snapshot.data;
                                  return StreamBuilder<int>(
                                    stream: depositBloc.outDepositsAmountTemp,
                                    initialData: 0,
                                    builder: (context,snapshot){
                                      final maxMoney = snapshot.data;
                                     // int totalz = total + maxMoney;
                                    //  FirestoreUserService.updateTotal(totalz);
                                      return Text('Rp $total',
                                        style: new TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontFamily: 'Raleway'
                                        ),
                                      ); 
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 5,),
                              Text("Pencapaianmu :",
                                style: new TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontFamily: 'Raleway'
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 5,),
                              Container(
                                width: 150,
                                height: 150,
                                color: Colors.transparent,
                                child: FlatButton(
                                  child: Image.asset('assets/bintang.png',scale: 1,),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (context){
                                        return RewardDreamTargetPopup();
                                      }
                                    );
                                  },
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                color: Colors.transparent,
                                child: FlatButton(
                                  child: Image.asset('assets/rp.png',scale: 3,),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (context){
                                        return RewardTotalTargetPopup();
                                      }
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
