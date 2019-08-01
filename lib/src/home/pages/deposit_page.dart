import 'dart:math';

import 'package:dram1y/models/deposit.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:dram1y/src/widgets/money_entry_tile.dart';
import 'package:dram1y/src/widgets/money_today_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dram1y/src/global_blocs/deposit_bloc.dart';

class DepositPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final depositBloc = Provider.of<DepositBloc>(context);
    return Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MoneyTodayLabel(),
                InkWell(
                  onTap: () => depositBloc.depositMoney(),
                    child: CircleButton(),
                ),
              ],
            )
          ),
          Expanded(
            flex: 3,
            child: StreamBuilder<List<Deposit>>(
              stream: depositBloc.outDeposits,
              initialData: [],
              builder: (context, snapshot) {
                final deposits = snapshot.data;
                return ListView.builder(
                  itemCount: deposits.length,
                  itemBuilder: (context,index){
                    final deposit = deposits[index];
                    return MoneyEntryTile(deposit: deposit);
                  },
                );
              },
            ),
          )
        ] 
      );
  }
}

class CircleButton extends StatefulWidget {
  const CircleButton({
    Key key,
  }) : super(key: key);

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

 @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _animationController.forward();
  }


  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    final depositBloc = Provider.of<DepositBloc>(context);
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(100),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 5,
          offset: Offset(0,2),
          ),
        ],
      ),
      child: Container(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, builder){
            return CustomPaint(
              foregroundPainter: CircleProgressPainter(Colors.grey, Colors.greenAccent, 24),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}

 class CircleProgressPainter extends CustomPainter{
    CircleProgressPainter(
      this.lineColor, 
      this.completeColor, 
      this.completePercent);

    final Color lineColor;
    final Color completeColor;
    final double completePercent;

  

    @override
    void paint(Canvas canvas, Size size){
      Paint line = Paint()
        ..color = lineColor
        ..strokeCap = StrokeCap.square
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20;
      
       Paint complateLine = Paint()
        ..color = completeColor
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20;

        Offset center = Offset(size.width / 2 , size.height / 2); 
        double radius = min(size.width / 2 - (size.width / 2), size.height / 2 - (size.height / 2));

        canvas.drawCircle(center, radius, line);

        double arcAngle = 2 * pi * (completePercent);

        canvas.drawArc(Rect.fromCircle(center:center, radius: radius), -pi / 2, arcAngle, false, complateLine);
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate){
      return true;
    }
  }
