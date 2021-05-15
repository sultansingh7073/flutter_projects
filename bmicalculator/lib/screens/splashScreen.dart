import 'dart:async';

import 'package:bmicalculator/constants/app_constant.dart';
import 'package:bmicalculator/screens/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainHexColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "BMI",
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                    color: accentHexColor),
              ),
              Text(
                "Calculate Your Body Mass Index",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: accentHexColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
