import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_mo_ro/views/home_sc.dart';
import 'package:me_mo_ro/views/login_sc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:me_mo_ro/views/splash_sc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
