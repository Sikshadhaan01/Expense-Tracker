import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    Timer(const Duration(seconds: 1,milliseconds:0 ), () { 
      var userId ="loggedout";
       if (userId == "logged") {
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
      body: Center(child: Container(width: 200,height: 300,
        decoration:const BoxDecoration(color: Colors.black),
      )),
    );
  }
}