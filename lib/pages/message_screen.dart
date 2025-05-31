import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Map<String, dynamic> payloadcontent = {};

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;

    if (data is RemoteMessage) {
      payloadcontent = data.data;
    } else if (data is NotificationResponse && data.payload != null) {
      payloadcontent = jsonDecode(data.payload!);
    }

    String firstkey =
        payloadcontent.isNotEmpty ? payloadcontent.keys.first : 'Unknown';
    String value = payloadcontent[firstkey]?.toString() ?? 'N/A';

    return Scaffold(
      appBar: AppBar(title: const Text("Message")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  color: Colors.purple,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "Book name: $firstkey",
                      style: const TextStyle(fontSize: 21, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  color: Colors.purple,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "Price: $value",
                      style: const TextStyle(fontSize: 21, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
