import 'package:book_stask_/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationHelper {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Initialize Firebase Messaging
  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
    );

    final token = await _firebaseMessaging.getToken();
    print("Device token: $token");
  }

  /// Initialize local notifications
  static Future<void> localNotificationInitialization() async {
    const AndroidInitializationSettings initializationSettingsForAndroid =
        AndroidInitializationSettings(
          "@mipmap/ic_launcher",
        ); // Correct icon path

    final DarwinInitializationSettings initializationSettingsForIOS =
        DarwinInitializationSettings(
          // onDidReceiveLocalNotification: (id, title, body, payload) async {
          //   // Handle iOS older versions
          // },
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsForAndroid,
          iOS: initializationSettingsForIOS,
        );

    // Request Android notification permission (for Android 13+)
    final androidPlugin =
        _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    await androidPlugin?.requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  /// Notification tap handler
  static void onNotificationTap(NotificationResponse notificationResponse) {
    print("Notification clicked: ${notificationResponse.payload}");
    navigator.currentState!.pushNamed(
      "/message",
      arguments: notificationResponse,
    );
    // Navigate or perform other actions based on payload
  }

  static Future showlocalNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channelId',
          'channelName',
          channelDescription: "channel description",
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
