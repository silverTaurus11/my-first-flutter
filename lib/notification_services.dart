
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class NotificationServices {
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  String groupKey = 'com.example.my_first_flutter';
  String groupChannelId = 'MY FLUTTER ID';
  String groupChannelName = 'MY FLUTTER';
  String groupChannelDescription = 'Only for my flutter';
  void Function(String payload) callBack = (payload) {};

  NotificationServices() {
    requestingPermissionForIOS();
    initNotifications();
  }

  void requestingPermissionForIOS() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  void initNotifications() {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {
        print(payload);
        callBack(payload ?? "");
        });
  }

  Future<void> showNotification(RemoteMessage message) async {
    Random random = Random();
    int randomNumber = random.nextInt(100);

    print(message.data);
    Map<String, dynamic> data = message.data;
    AndroidNotification? android = message.notification?.android;

    flutterLocalNotificationsPlugin.show(
      randomNumber,
      data['title'],
      data['body'],
      NotificationDetails(
          android: await createAndroidNotificationDetails(data, randomNumber.toString(), android?.smallIcon ?? ""),
          iOS: await createIOSNotificationDetails(data, randomNumber.toString(), android?.smallIcon ?? "")),
      payload: data["directlink"],
    );
  }

  _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<IOSNotificationDetails> createIOSNotificationDetails(Map<String, dynamic> data,
      String uniqueId, String icon) async {
    late IOSNotificationDetails iosNotificationDetails;
    if (data['image'] != "" && data['image'] != "null") {
      var attachmentPicturePath = await _downloadAndSaveFile(data["image"], "image-$uniqueId");

      iosNotificationDetails = IOSNotificationDetails(
          attachments: [IOSNotificationAttachment(attachmentPicturePath)],
          presentAlert: true,
          presentSound: true,
          threadIdentifier: "my_flutter"
      );

    } else {
      iosNotificationDetails = const IOSNotificationDetails(
          presentAlert: true,
          presentSound: true,
          threadIdentifier: "my_flutter");
    }
    return iosNotificationDetails;
  }

  Future<AndroidNotificationDetails> createAndroidNotificationDetails(Map<String, dynamic> data,
      String uniqueId, String icon) async {
    late AndroidNotificationDetails androidNotificationDetails;
    if (data['image'] != "" && data['image'] != "null") {
      var attachmentPicturePath = await _downloadAndSaveFile(data["image"], "image-$uniqueId");

      var bigPictureStyleInformation = BigPictureStyleInformation(
          FilePathAndroidBitmap(attachmentPicturePath),
          largeIcon: null,
          contentTitle: '<b>Attached Image</b>',
          htmlFormatContentTitle: true,
          htmlFormatSummaryText: true);

      androidNotificationDetails = AndroidNotificationDetails(
          groupChannelId,
          groupChannelName,
          channelDescription: groupChannelDescription,
          icon: icon,
          importance: Importance.max,
          priority: Priority.high,
          groupKey: groupKey,
          setAsGroupSummary: true,
          largeIcon: FilePathAndroidBitmap(attachmentPicturePath),
          styleInformation: bigPictureStyleInformation);
    } else {
      androidNotificationDetails = AndroidNotificationDetails(
          groupChannelId,
          groupChannelName,
          channelDescription: groupChannelDescription,
          icon: icon,
          importance: Importance.max,
          priority: Priority.high,
          groupKey: groupKey,
          setAsGroupSummary: true);
    }
    return androidNotificationDetails;
  }
}