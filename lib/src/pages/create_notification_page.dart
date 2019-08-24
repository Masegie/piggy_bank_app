import 'package:dram1y/models/notification_data.dart';
import 'package:dram1y/src/widgets/buttons/custom_wide_flat_button.dart';
import 'package:dram1y/src/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dram1y/src/global_blocs/notification_bloc.dart';
import 'package:dram1y/src/global_blocs/app_bloc.dart';
import 'package:provider/provider.dart';

class CreateNotificationPage extends StatefulWidget {
  @override
  _CreateNotificationPageState createState() => _CreateNotificationPageState();
}

class _CreateNotificationPageState extends State<CreateNotificationPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final notificationBloc = Provider.of<AppBloc>(context).notificationBloc;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Create Notification',
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
               child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Placeholder(),
                        ),
                      ),
                    ),
                    CustomInputField(
                      controller: _titleController,
                      hintText: 'Title',
                      inputType: TextInputType.text,
                      autoFocus: true,
                    ),
                    SizedBox(height: 12),
                    CustomInputField(
                      controller: _descriptionController,
                      hintText: 'Description',
                      inputType: TextInputType.text,
                      autoFocus: true,
                    ),
                    SizedBox(height: 12),
                    OutlineButton(
                     onPressed: selectTime,
                     color: Colors.blue,
                     child: Text(selectedTime.format(context)),
                   )
                  ],
                ),
              ),
            ),
          ),
         CustomWideFlatButton(
           onPressed: () => createNotification(notificationBloc),
           backgroundColor: Colors.blue.shade300,
           foregroundColor: Colors.blue.shade900,
           isRoundedAtBottom: false,
         ),
        ],
      ),
    );
  }

  Future<void> selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void createNotification(NotificationBloc notificationBloc) {
    if (_formKey.currentState.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;

      final notificationData = NotificationData(title, description, selectedTime.hour, selectedTime.minute);
      notificationBloc.addNotification(notificationData);
      Navigator.of(context).pop(notificationData);
    }
  }
}