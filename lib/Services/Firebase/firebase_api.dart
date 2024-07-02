import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../Models/push_notification.dart';
import '../../Models/received_notification.dart';


Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print("Handling a background Title: ${message.notification?.title}");
    print("Handling a background Title: ${message.notification?.body}");
  }
}

class FirebaseApi extends ChangeNotifier {
  final _firebaseMessaging = FirebaseMessaging.instance;
  PushNotification? _notificationInfo;

  PushNotification? get notificationInfo => _notificationInfo;

  String? _fcmToken;

  String? get fcmToken => _fcmToken;

  int _id = 0;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    _fcmToken = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      log("Token: $_fcmToken");
    }

    _requestAndRegisterNotification();
    notifyListeners();
  }

  void _requestAndRegisterNotification() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }

      _requestPermission();
      _initializeNotification();

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        _notificationInfo = notification;

        if (_notificationInfo != null) {
          if (kDebugMode) {
            print('push notification received');
            print(_notificationInfo!.title);
            print(_notificationInfo!.body);
          }
          await _displayNotification(
              body: _notificationInfo!.body!, title: _notificationInfo!.title!);
        }
      });
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }
  }

  listenForNotifications() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );

      _notificationInfo = notification;
      if (_notificationInfo != null) {
        if (kDebugMode) {
          print(_notificationInfo!.title);
          print(_notificationInfo!.body);
        }
        await _displayNotification(
            body: _notificationInfo!.body!, title: _notificationInfo!.title!);
      }
      notifyListeners();
    });
  }



  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final StreamController<ReceivedNotification>
      _didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();

  final List<DarwinNotificationCategory> _darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      'textCategory',
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      'plainCategory',
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          'id_3',
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle
      },
    )
  ];

  ///This function is used to request permission to display notifications on the device
  void _requestPermission() {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  ///This function is used to setup the platform specific logic
  _initializeNotification() async {
    // _getTimeZones();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            notificationCategories: _darwinNotificationCategories,
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('Notification Payload: $payload');
      try {
        // if (_navigateTo != null) {
        //   if (!_navigated) {
        //     _navigated = true;
        //     Navigator.pushNamed(_context, _navigateTo!);
        //     notifyListeners();
        //   }
        // }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  ///This function is used to instantly display a notification to the user
  _displayNotification(
      {required String body,
      required String title,
      String? navigatesTo,
      String? group,
      payload}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('unisafe001', 'UniSafe',
            groupKey: group,
            channelDescription:
                'Channel to display notifications from the UniSafe App',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(threadIdentifier: group);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        _id, title, body, notificationDetails,
        payload: payload.toString());
    _id++;

    notifyListeners();

    // navigatesTo;
  }
}
