/*import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationService {
  NotificationService._privateConstructor();
  static final NotificationService _instance =
      NotificationService._privateConstructor();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _fln =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Android init
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('appicon');

    // iOS init (Darwin)
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _fln.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Called when user taps a notification
        final payload = response.payload;
        // TODO: handle navigation with payload
      },
    );

    // Create Android channel (required for Android 8+)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'todo_channel', // id
      'ToDo Notifications', // title
      description: 'Channel for task reminders',
      importance: Importance.max,
    );

    await _fln
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Timezone initialization (required for zonedSchedule)
    tzdata.initializeTimeZones();
    final String localTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localTimeZone));
  }

  // Show immediately
  Future<void> showNotification(
    int id,
    String title,
    String body, {
    String? payload,
  }) async {
    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'todo_channel',
        'ToDo Notifications',
        channelDescription: 'Task reminders',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _fln.show(id, title, body, details, payload: payload);
  }

  // Schedule (time-zone aware)
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    final tz.TZDateTime tzScheduled = tz.TZDateTime.from(
      scheduledDate,
      tz.local,
    );

    if (tzScheduled.isBefore(tz.TZDateTime.now(tz.local))) {
      // If time already passed you can either show now or skip
      await showNotification(id, title, body, payload: payload);
      return;
    }

    await _fln.zonedSchedule(
      id,
      title,
      body,
      tzScheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'todo_channel',
          'ToDo Notifications',
          channelDescription: 'Task reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  Future<void> requestNotificationPermissions() async {
    if (Platform.isAndroid) {
      // Android 13+ uses runtime POST_NOTIFICATIONS permission
      final status = await Permission.notification.status;
      if (status.isDenied) {
        await Permission.notification.request();
      }
    } else if (Platform.isIOS) {
      final fln = FlutterLocalNotificationsPlugin();
      await fln
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  Future<void> cancel(int id) => _fln.cancel(id);
  Future<void> cancelAll() => _fln.cancelAll();
}*/
