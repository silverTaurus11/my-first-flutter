

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_first_flutter/page/login_page.dart';

import '../my_helper.dart';
import 'dashboard/main_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Future.delayed(const Duration(milliseconds: 2500), () {
      MyHelper.getProfileItemFromLocal().then((value) => {
        if (value != null) {
          Navigator.pushReplacementNamed(context, MainPage.routeName)
        } else {
          Navigator.pushReplacementNamed(context, LoginPage.routeName)
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Stack(
         fit: StackFit.expand,
         children: <Widget> [
           Container(
             decoration: const BoxDecoration(color: Colors.cyan),
           ),
           Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget> [
               Expanded(
                   flex: 2,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: const <Widget> [
                     CircleAvatar(
                       backgroundColor: Colors.white,
                       radius: 50,
                       child: Icon(Icons.shopping_cart, color: Colors.greenAccent, size: 50),
                     ),
                     Padding(padding: EdgeInsets.only(top: 10)),
                     Text(
                         "My Products",
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: 24.0,
                             fontWeight: FontWeight.bold
                         ))
                     ],
                   ),
               ),
               Expanded(
                   flex: 1,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget> [
                       Lottie.asset(
                         'lib/assets/icon/loading-animation.json',
                         controller: _controller,
                         height: 50,
                         onLoaded: (composition) {
                           // Configure the AnimationController with the duration of the
                           // Lottie file and start the animation.
                           _controller
                             ..duration = composition.duration
                             ..forward();
                         },
                       ),
                       const Padding(padding: EdgeInsets.only(top: 5)),
                       const Text("Online Store\nFor Everyone",
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 18,
                           fontWeight: FontWeight.bold
                         ))
                     ],
                   ))
             ]
           )
         ],
       ),
     );
  }


}