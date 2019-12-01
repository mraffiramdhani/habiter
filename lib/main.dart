import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habiter/homeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habiter',
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        'HOME_SCREEN': (BuildContext context) => new HomeScreen()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  Animation<int> _characterCount;

  int _stringIndex;
  static const List<String> _kStrings = const <String>[
    'Habiter',
  ];
  String get _currentString => _kStrings[_stringIndex % _kStrings.length];
  
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  startType() async {
    AnimationController controller = new AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    setState(() {
      _stringIndex = _stringIndex == null ? 0 : _stringIndex + 1;
      _characterCount = new StepTween(begin: 0, end: _currentString.length)
        .animate(new CurvedAnimation(parent: controller, curve: Curves.easeIn));
    });
    await controller.forward();
    controller.dispose();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('HOME_SCREEN');
  }

  @override
  void initState() {
    super.initState();
    startTime();
    startType();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        width: 360,
        height: 640,
        decoration: BoxDecoration(
          color: const Color(0xffd84a4a)
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 279, left: 93),
          child: SizedBox(
            width: 174,
            height: 82,
            child: _characterCount == null ? null : new AnimatedBuilder(
              animation: _characterCount,
              builder: (BuildContext context, Widget child) {
                String text = _currentString.substring(0, _characterCount.value);
                return new Text(text, style: TextStyle(color: Colors.white, fontFamily: 'Nunito', fontSize: 50.0));
              },
            ),
          ),
        )
      )
    );
  }

}
