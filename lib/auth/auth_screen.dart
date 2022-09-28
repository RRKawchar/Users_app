import 'package:flutter/material.dart';
import 'package:users_app/auth/login_screen.dart';
import 'package:users_app/auth/registration_screen.dart';
import 'package:users_app/utils/colors.dart';
import 'package:users_app/widgets/reuseble_text.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [pinkAccent, purpleAccent],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            title: ReusebleText(
              text: "iShop",
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
            centerTitle: true,
            bottom:const TabBar(
              indicatorColor:Colors.white54,
              indicatorWeight: 6,
              tabs: [
                Tab(
                  text: "Login",
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  text: "Registration",
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            decoration:const BoxDecoration(
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
            child:const TabBarView(
                children: [
                  LoginScreen(),
                  RegistrationScreen()
                ]
            ),
          ),
        ));
  }
}
