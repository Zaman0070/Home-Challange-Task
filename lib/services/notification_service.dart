import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final DarwinInitializationSettings initializationSettingsDarwin =
      const DarwinInitializationSettings();
  static void initialize() {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  

  //

  static Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      '[Utils.requestPermission()] - Permission ${permission.toString()} was already granted';
      return true;
    } else {
      final result = await permission.request();
      if (result == PermissionStatus.granted) {
        '[Utils.requestPermission()] - Permission ${permission.toString()} granted!';
        return true;
      } else {
        '[Utils.requestPermission()] - Permission ${permission.toString()} denied!';
        return false;
      }
    }
  }

  final platformNotificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
      ),
      iOS: DarwinNotificationDetails());

  static Future<void> showNotification({
    required String title,
    required String body,
    int? id,
  }) async {
    await _flutterLocalNotificationsPlugin.show(
      id ?? Random().nextInt(1000),
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          channelDescription: 'channel description',
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
