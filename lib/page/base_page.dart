

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_first_flutter/notification_services.dart';
import 'package:my_first_flutter/page/dashboard/main_page.dart';

import 'dashboard/firebase/firebase_notification_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BasePageState();

}

class BasePageState<T extends BasePage> extends State<T> {

  late FirebaseMessaging messaging;
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      initListener(value);
    });
  }

  void initListener(String? token){
    FirebaseMessaging.onMessage.listen((message){
      notificationServices.showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });

    print("$token");
  }

  @override
  Widget build(BuildContext context) {
    notificationServices.callBack = (payload) {
      if (payload == "/home") {
        Navigator.pushNamed(context, MainPage.routeName);
      }
    };
    return createLayout(context);
  }

  Widget createLayout(BuildContext context) {
    return const Scaffold();
  }

}