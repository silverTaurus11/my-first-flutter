

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotification extends StatefulWidget {
  static const routeName = '/firebase_notification';

  const FirebaseNotification({Key? key}) : super(key: key);

  @override
  _FirebaseNotificationState createState() => _FirebaseNotificationState();
}

class _FirebaseNotificationState extends State<FirebaseNotification> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  final controllerTopic = TextEditingController();
  bool isSubscribed = false;
  String token = '';
  static String dataName = '';
  static String dataAge = '';
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("messaging");
    messaging.getToken().then((value) {
      initListener(value);
    });
    initListener(token);
  }

  void initListener(String? token){
    FirebaseMessaging.onMessage.listen((message){
      log("message recieved");
      print(message.notification!.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
    });

    log("$token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('Flutter FCM'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'TOKEN',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(token),
            Divider(thickness: 1),
            const Text(
              'TOPIC',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: controllerTopic,
              enabled: !isSubscribed,
              decoration: const InputDecoration(
                hintText: 'Enter a topic',
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: const Text('Subscribe'),
                    onPressed: isSubscribed ? null : () {
                      String topic = controllerTopic.text;
                      if (topic.isEmpty) {
                        scaffoldState.currentState?.showSnackBar(const SnackBar(
                          content: Text('Topic invalid'),
                        ));
                        return;
                      }
                      //firebaseMessaging.subscribeToTopic(topic);
                      setState(() {
                        isSubscribed = true;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: RaisedButton(
                    child: Text('Unsubscribe'),
                    onPressed: !isSubscribed ? null : () {
                      String topic = controllerTopic.text;
                      //firebaseMessaging.unsubscribeFromTopic(topic);
                      setState(() {
                        isSubscribed = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Divider(thickness: 1),
            const Text(
              'DATA',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildWidgetTextDataFcm(),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetTextDataFcm() {
    if (dataName == null || dataName.isEmpty || dataAge == null || dataAge.isEmpty) {
      return const Text('Your data FCM is here');
    } else {
      return Text('Name: $dataName & Age: $dataAge');
    }
  }

  void getDataFcm(Map<String, dynamic> message) {
    String name = '';
    String age = '';
    if (Platform.isIOS) {
      name = message['name'];
      age = message['age'];
    } else if (Platform.isAndroid) {
      var data = message['data'];
      name = data['name'];
      age = data['age'];
    }
    if (name.isNotEmpty && age.isNotEmpty) {
      setState(() {
        dataName = name;
        dataAge = age;
      });
    }
    log('getDataFcm: name: $name & age: $age');
  }
}