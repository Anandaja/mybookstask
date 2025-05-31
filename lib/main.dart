import 'dart:convert';

import 'package:book_stask_/auth/ui/login_screen.dart';
import 'package:book_stask_/auth/ui/sign_screen.dart';
import 'package:book_stask_/firebase_options.dart';
import 'package:book_stask_/pages/home.dart';
import 'package:book_stask_/pages/message_screen.dart';
import 'package:book_stask_/service/auth_service.dart';
import 'package:book_stask_/service/notification_service.dart';
import 'package:book_stask_/utils/toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

final navigator = GlobalKey<NavigatorState>();

Future _firebaseMessaging(RemoteMessage message) async {
  if (message.notification != null) {
    print("a notification found in background");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Needed for async before runApp
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Correct Firebase initialization

  await PushNotificationHelper.init();
  await PushNotificationHelper.localNotificationInitialization();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessaging);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("background notification tapp");
      navigator.currentState!.pushNamed("/message", arguments: message);
    }
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadcontent = jsonEncode(message.data);
    print("message found in background");
    if (message.notification != null) {
      PushNotificationHelper.showlocalNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadcontent,
      );
    }
  });

  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();
  if (message != Null) {
    print("from terminated state");
    Future.delayed(Duration(seconds: 4), () {
      navigator.currentState!.pushNamed("/message", arguments: message);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      navigatorKey: navigator,
      routes: {
        "/": (context) => checkuserbookstask(),
        "/login": (context) => LoginScreen(),
        "/home": (context) => home(),
        "/signup": (context) => SignScreen(),
        "/message": (context) => MessageScreen(),
      },
    );
  }
}

class checkuserbookstask extends StatefulWidget {
  const checkuserbookstask({super.key});

  @override
  State<checkuserbookstask> createState() => _checkuserbookstaskState();
}

class _checkuserbookstaskState extends State<checkuserbookstask> {
  @override
  void initState() {
    AuthService.isuserloggedin().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
