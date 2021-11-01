
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/page/dashboard/firebase/firebase_analytical_page.dart';

import 'firebase/firebase_notification_page.dart';

class FirebaseMainPage{

  static Widget builds(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFF6200EE),
              textStyle: const TextStyle(fontSize: 14)),
          onPressed: () {
            Navigator.pushNamed(context, FirebaseAnalyticalPage.routeName);
          },
          child: const Text('Firebase Analytical'),
        )]
    );
  }
}