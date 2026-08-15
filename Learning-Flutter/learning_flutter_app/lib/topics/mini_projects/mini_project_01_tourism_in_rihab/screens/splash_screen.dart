import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learning_flutter_app/screens/topics/mini_projects/mini_project_01_tourism_in_rihab/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 1), () {
      // What to do if you want to work on a temp for a while?
      Navigator.of(
        context,
        // Replace not push, as we dont want it in the stack
      ).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 250, height: 250),
            Text('Tourism In Rehab', style: TextStyle(fontSize: 24)),
            Text('السياحة في رحاب', style: TextStyle(fontSize: 24)),
            SizedBox(height: 30),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
