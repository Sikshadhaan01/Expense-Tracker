import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  get prefs => null;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1, milliseconds: 0), ()async {
      SharedPreferences prefs =await SharedPreferences.getInstance();
      var userInfo = prefs.getString("userInfo");
      var userId = "logged";
      if (userInfo != null) {
        // ignore: use_build_context_synchronously
        context.pushReplacement("/");
      } else {
        // ignore: use_build_context_synchronously
        context.pushReplacement('/Login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
      image: AssetImage("assets/front family1.jpg.png"),
    ))));
  }
}
