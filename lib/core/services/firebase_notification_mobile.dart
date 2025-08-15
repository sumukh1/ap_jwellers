import 'package:myapp/core/services/log_utility.dart';
import 'package:myapp/core/widget/app_dialoag.dart';
import 'package:myapp/di/injection.dart';
import 'package:myapp/static/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging? _firebaseMessaging;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService(this._firebaseMessaging);

  Future<void> init() async {
    if (!kIsWeb && _firebaseMessaging != null) {
      LogUtility.warning('Initializing Firebase Messaging');

      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      await _initLocalNotification(); // ✅ ADD THIS

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print('Foreground message received: ${message.notification?.title}');
        // _showLocalNotification(message); // ✅ CHANGED
        await playNotificationSound();
        showTopNotificationBanner(
          title: message.notification!.title ?? "New Notification",
          message: message.notification!.body ?? "",
          onTap: () {
            handleNotificationMessage(message);
          },
        );
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print(
            'Notification caused app to open: ${message.notification?.title}');
        handleNotificationMessage(message);
      });

      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print(
            'App launched via notification: ${initialMessage.notification?.title}');
        handleNotificationMessage(initialMessage);
      }
    }
  }

  Future<void> _initLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging?.getToken();
  }

  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;
  Stream<RemoteMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  Future<bool?> showNotificationAlert(RemoteMessage message) async {
    return showDialog<bool>(
      context: Injection.currentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AppDialog(
          title: message.notification?.title,
          message: message.notification?.body ?? '',
        );
      },
    );
  }
}

Future<void> playNotificationSound() async {
  final player = AudioPlayer();
  await player.play(AssetSource('audio/notification.wav'));
}

//Top Notification in app
void showTopNotificationBanner({
  required String title,
  required String message,
  required VoidCallback onTap,
}) {
  final overlay = Injection.navigatorState.currentState?.overlay;
  if (overlay == null) return;

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 12,
        right: 12,
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.up,
          onDismissed: (_) => overlayEntry.remove(),
          child: GestureDetector(
            onTap: () {
              overlayEntry.remove();
              onTap();
            },
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              color: Constants.WHITE,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.notifications, color: Constants.PURPLE),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Constants.PURPLE,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(message,
                              style: TextStyle(
                                  fontSize: 14, color: Constants.PURPLE)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 5), () {
    if (overlayEntry.mounted) overlayEntry.remove();
  });
}

//
void handleNotificationMessage(RemoteMessage message) {
  Future.delayed(const Duration(seconds: 2), () {
    try {
      LogUtility.warning(
          'NotificationService: handleNotificationMessage: Notification tapped');
      final data = message.data;
      LogUtility.warning('NotificationService: Received message data: $data');

      // final notificationData = NotificationData.fromMap(data);
    } catch (e, st) {
      LogUtility.error("Error handling message: $e\n$st");
    }
  });
}

class NotificationData {
  final String? page;
  final int? employeeId;
  final int? clientId;
  final int? adminId;
  final int? meetingId;
  final int? todoId;
  final int? workId;

  NotificationData({
    this.page,
    this.workId,
    this.employeeId,
    this.clientId,
    this.adminId,
    this.meetingId,
    this.todoId,
  });

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      page: map['page'],
      workId:
          map['workId'] != null ? int.tryParse(map['workId'].toString()) : null,
      employeeId: map['staffId'] != null
          ? int.tryParse(map['staffId'].toString())
          : null,
      clientId: map['clientId'] != null
          ? int.tryParse(map['clientId'].toString())
          : null,
      adminId: map['adminId'] != null
          ? int.tryParse(map['adminId'].toString())
          : null,
      meetingId: map['meetingId'] != null
          ? int.tryParse(map['meetingId'].toString())
          : null,
      todoId:
          map['todoId'] != null ? int.tryParse(map['todoId'].toString()) : null,
    );
  }
}
