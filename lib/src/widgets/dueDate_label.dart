import 'package:dram1y/src/global_blocs/deposit_bloc.dart';
import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DueDateLabel extends StatefulWidget {
  const DueDateLabel({
    Key key,
  }) : super(key: key);

  @override
  _DueDateLabelState createState() => _DueDateLabelState();
}

class _DueDateLabelState extends State<DueDateLabel> with SingleTickerProviderStateMixin {
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
    DateTime thisDay = new DateTime.now();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder<DateTime>(
        stream: userBloc.outDueDate,
        initialData: DateTime.now(),
        builder: (context, snapshot) {
          final dueDate = snapshot.data;
          final theDay = dueDate.difference(thisDay).inDays;
          return StreamBuilder<int>(
            stream: depositBloc.outDepositsAmount,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _fadeInController.forward();
                return AnimatedBuilder(
                  animation: _fadeInController,
                  builder: (context,child) {
                    return Opacity(
                      opacity: _fadeInController.value,
                      child: Text(
                        '$theDay Hari lagi',
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