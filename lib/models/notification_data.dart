import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationData {
  String title;
  String description;
  Time time;

  NotificationData(this.title,this.description,this.time);

  // NotificationData.fromDb(Map<String, dynamic> json, String id) {
  //   this.title = json[titleField];
  //   this.description = json[descriptionField];
  //   this.time = json[timeField];
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     titleField: this.title,
  //     descriptionField: this.description,
  //     timeField: this.time,
  //   };
  // }
}