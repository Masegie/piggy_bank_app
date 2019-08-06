import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPlugin {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationPlugin() {
    _initializeNotifications();
  }

  void _initializeNotifications() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializationSettingsAndroid = AndroidInitializationSettings('secondary_icon');
    final initializationSettingsIOS = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(initializationSettingsAndroid,initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload' + payload);
    }
  }

  Future<void> showWeeklyAtDayAndTime(Time time, Day day, int id,String title, String description) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'show me weekly channel id',
      'show me weekly channel name',
      'show me weekly description'
    );
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelsSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(id, title, description, day, time, platformChannelsSpecifics);
  }

  Future<List<PendingNotificationRequest>> getScheduledNotifications() async {
    final pendingNotifications = await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  Future cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
