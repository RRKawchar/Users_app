import 'dart:async';

import 'package:flutter/material.dart';
import 'package:users_app/main_screen/home_screen.dart';
import 'package:users_app/utils/colors.dart';
import 'package:users_app/widgets/reuseble_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  splashScreenTimer(){

    Timer(const Duration(seconds: 4),(){

      Navigator.push(context, MaterialPageRoute(builder: (c)=>const HomeScreen()));

    });

  }

  @override
  void initState() {
    splashScreenTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
       child: Container(
         decoration: const BoxDecoration(
           gradient: LinearGradient(
               colors: [
                 pinkAccent,purpleAccent
               ],
               begin: FractionalOffset(0.0,0.0),
               end: FractionalOffset(1.0,0.0),
               stops: [
                 0.0,1.0
               ],
               tileMode: TileMode.clamp
           ),

         ),
         child:Center(
           child:Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [

               Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Image.asset(
                   "images/welcome.png"
                 ),
               ),
               const SizedBox(height: 10,),

               ReusebleText(text: "iShop Users App",fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white,letterSpacing: 3,),

               const SizedBox(height: 12,),
              const CircularProgressIndicator(
                 backgroundColor: Colors.white,
               )
             ],
           )
         )
       ),
    );
  }
}
