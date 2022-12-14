import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_app/auth/auth_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/main_screen/home_screen.dart';
import 'package:users_app/model_practice/product_view.dart';
import 'package:users_app/model_practice/signup_practice.dart';

import 'package:users_app/splashScreen/splash_screen.dart';



Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ProductView(),
    );
  }
}


