import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreamNameLabel extends StatefulWidget {
  const DreamNameLabel({
    Key key,
  }) : super(key: key);

  @override
  _DreamNameLabelState createState() => _DreamNameLabelState();
}

class _DreamNameLabelState extends State<DreamNameLabel> with SingleTickerProviderStateMixin {
  AnimationController _fadeInController;
  
  @override
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    final depositBloc = Provider.of<DepositBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder<String>(
        stream: userBloc.outDreamName,
        initialData: '1',
        builder: (context, snapshot) {
          final dreamName = snapshot.data;
          return StreamBuilder<int>(
            stream: depositBloc.outDepositsAmount,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final moneyAmount  = snapshot.data;
                _fadeInController.forward();
                return AnimatedBuilder(
                  animation: _fadeInController,
                  builder: (context,child) {
                    return Opacity(
                      opacity: _fadeInController.value,
                      child: Text(
                        '$dreamName',
                        style: Theme.of(context).textTheme.title,
                      ),
                    );
                  },
                );
              }
              return SizedBox(height: 24);
            },
          );
        }
      ),
    );
  }
}