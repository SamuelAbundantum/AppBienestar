import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';

import '../../domain/entities/hora.dart';
import 'dbSambami.dart';

class NotificationHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationHelper(this.flutterLocalNotificationsPlugin) {
    tz.initializeTimeZones();
    _initializeNotificationPlugin();
  }

  void _initializeNotificationPlugin() {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<Hora> _getScheduledTime() async {
    try {
      return await DB.getHora(1);
    } catch (e) {
      return Hora(id: 1, hora: TimeOfDay(hour: 8, minute: 0));
    }
  }

  Future<void> scheduleDailyNotification() async {
    Hora scheduledTime = await _getScheduledTime();
    TimeOfDay time = scheduledTime.hora;
    tz.TZDateTime scheduledDate = _nextInstanceOfTime(time.hour, time.minute);

    var androidDetails = const AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSDetails = const DarwinNotificationDetails();
    var platformDetails = NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Recordatorio Diario',
      'Recuerda poner cómo te has sentido para mejorar tu progreso',
      scheduledDate,
      platformDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}
