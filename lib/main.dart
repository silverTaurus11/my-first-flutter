import 'dart:developer';

import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/notification_services.dart';
import 'package:my_first_flutter/page/dashboard/firebase/firebase_analytical_page.dart';
import 'package:my_first_flutter/page/dashboard/firebase/firebase_notification_page.dart';
import 'package:my_first_flutter/page/dashboard/firebase/firebase_tab_page.dart';
import 'package:my_first_flutter/page/dashboard/main_page.dart';
import 'package:my_first_flutter/page/login_page.dart';
import 'package:my_first_flutter/page/splash_screen_page.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationServices notificationServices = NotificationServices();
  notificationServices.showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken().then((value) => {
    FirebaseMessaging.onBackgroundMessage(_messageHandler)
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

    // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Products',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      initialRoute: SplashScreen.routeName,
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        MainPage.routeName: (context) => MainPage(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        FirebaseAnalyticalPage.routeName: (context) => const FirebaseAnalyticalPage(),
        TabsPage.routeName: (context) => TabsPage(
            ModalRoute.of(context)?.settings.arguments as FirebaseAnalyticsObserver),
        FirebaseNotification.routeName: (context) => FirebaseNotification()
      },
    );
  }
}
