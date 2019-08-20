import 'package:dram1y/models/notification_data.dart';
import 'package:dram1y/plugins/notification_plugin.dart';
import 'package:dram1y/src/pages/create_notification_page.dart';
import 'package:dram1y/src/widgets/buttons/custom_wide_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationPlugin _notificationPlugin = NotificationPlugin();
  Future<List<PendingNotificationRequest>> notificationFuture;

  @override
  void initState() { 
    super.initState();
    notificationFuture = _notificationPlugin.getScheduledNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          FutureBuilder<List<PendingNotificationRequest>>(
            future: notificationFuture,
            initialData: [],
            builder: (context, snapshot) {
              final notifications = snapshot.data;
              if(notifications.isEmpty)
                return Expanded(
                  child: Center(
                    child: Container(
                      height: 300,
                      width: 300,
                      child: Placeholder(),
                    ),
                  ),
                );
              return Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return NotificationTile(notification: notification,
                    deleteNotification: dismissNotification,
                    );
                  },
                ),
              );
            },
          ),
          // FlatButton(
          //   padding: EdgeInsets.all(0),
          //   onPressed: navigateToNotificationCreation,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(5),
          //       bottomRight: Radius.circular(5),
          //     ),
          //   ),
          //   color: Colors.blue.shade300,
          //   child: Container(
          //     alignment: Alignment.center,
          //     height: 50,
          //     width: double.infinity,
          //     child: Text(
          //       'create',
          //       style: TextStyle(
          //         color: Colors.blue.shade900,
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //       ),  
          //     ),
          //   ),
          // )
          CustomWideFlatButton(
            onPressed: navigateToNotificationCreation,
            backgroundColor: Colors.blue.shade300,
            foregroundColor: Colors.blue.shade900,
            isRoundedAtBottom: false,
          ),
        ],
      ),
    );
  }

  Future<void> dismissNotification(int id) async {
    await _notificationPlugin.cancelNotification(id);
    refreshNotification();
  }

  void refreshNotification(){
    setState(() {
     notificationFuture = _notificationPlugin.getScheduledNotifications(); 
    });
  }

  Future<void> navigateToNotificationCreation() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateNotificationPage(),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key key,
    @required this.notification,
    @required this.deleteNotification, 
  }) : super(key: key);

  final PendingNotificationRequest notification;
  final Function(int id) deleteNotification;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      // child: ListTile(
      //   title: Text(notification.title),
      //   subtitle: Text(notification.body),
      //   trailing: IconButton(
      //     onPressed: () => deleteNotification(notification.id),
      //     icon: Icon(Icons.delete)
      //   ),
      // ),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    notification.title,
                    style: textTheme.title.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  smallHeight,
                  Text(
                    notification.body,
                    style: textTheme.subtitle.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  smallHeight,
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 28,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(width: 12),
                      Text(
                        '12:42',
                        style: textTheme.headline.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () => deleteNotification(notification.id),
              icon: Icon(Icons.delete, size: 32),
            )
          ],
        ),
      ),
    );
  }

  SizedBox get smallHeight => SizedBox(height: 8);
 }