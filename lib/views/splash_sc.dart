import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:me_mo_ro/views/login_sc.dart';
import 'package:me_mo_ro/views/signup_sc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

import 'add_sc.dart';
import 'home_sc.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //function to change spalsh screen
  void changeSc() {
    // creating firebaseAuth Instance
    final auth = FirebaseAuth.instance;

    // looking for user
    final user = auth.currentUser;

    Timer(Duration(seconds: 3), () {
      // if user is not null means user is already registered
      if (user != null) {
        Get.to(() => HomeScreen());
      } else {
        //if user is new then will have to Register First
        Get.to(() => SignUpScreen());
      }
    });
  }

  @override
  void initState() {
    changeSc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/memories.png'),
          ],
        ),
      ),
    );
  }
}
