import 'package:bmicalculator/screens/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: SplashScreen(),
    );
  }
}
