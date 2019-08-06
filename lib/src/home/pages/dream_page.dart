import 'package:dram1y/src/global_blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreamPage extends StatefulWidget {
  @override
  _DreamPageState createState() => _DreamPageState();
}

class _DreamPageState extends State<DreamPage> {
  final _controller = TextEditingController();
  Icon _errorIcon;
  
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        verticalDirection: VerticalDirection.down,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Input Your Dream',
            style: Theme.of(context).textTheme.title.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          smallSpace,
          Padding(
            padding: const EdgeInsets.all(9),
            child: Container(
              child: TextField(
                controller: _controller,
                onSubmitted: (value) => setValue(value,userBloc),
                autofocus: true,
                decoration: InputDecoration(
                  suffixIcon: _errorIcon,
                  fillColor: Colors.grey.shade300,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5)
                    )
                  )
                ),
              ),
            ),
          ),
          largeSpace,
          okButton(userBloc,context),
        ],
      ),
    );
  }

  FlatButton okButton(UserBloc userBloc, BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.all(8),
      onPressed: () => setValue(_controller.text, userBloc),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        )
      ),
      color: Theme.of(context).accentColor,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.maxFinite,
        child: Text('Ok'),
      ),
    );
  }

  Widget get smallSpace => SizedBox(height: 12);
  Widget get largeSpace => SizedBox(height: 24);

  void setValue(String nameAsString, UserBloc userBloc) {
    Icon error = Icon(Icons.error, color: Colors.red,);
    if(nameAsString.isEmpty) {
      setState(() {
       _errorIcon = error; 
      });
      return;
    }
    setState(() {
     _errorIcon = null; 
    });

    String name = nameAsString;
    userBloc.setDreamName(name);
    Navigator.of(context).pop();
  }
}