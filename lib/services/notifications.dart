import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:typed_data';

class NotificationService {
  // Singleton pattern
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('warning');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
    print('[NotificationService] Initialized successfully');
  }

  Future<void> showAlarmNotification() async {
    try {
      print('[NotificationService] Preparing to show alarm notification');

      final AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'alarm_channel',
            'Alarm Notification',
            channelDescription: 'Channel untuk alarm bahaya',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            vibrationPattern: Int64List.fromList(const [0, 1000, 500, 2000]),
            sound: const RawResourceAndroidNotificationSound('alarm'),
            largeIcon: DrawableResourceAndroidBitmap('warning'),
            icon: '@mipmap/ic_launcher',
          );

      final NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        0,
        '🚨 PERINGATAN BAHAYA',
        'Status saat ini: BAHAYA',
        notificationDetails,
      );

      print('[NotificationService] Alarm notification displayed');
    } catch (e) {
      print('[NotificationService] Failed to show notification: $e');
    }
  }
}
