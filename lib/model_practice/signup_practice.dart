import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpPractice extends StatefulWidget {
  const SignUpPractice({Key? key}) : super(key: key);

  @override
  State<SignUpPractice> createState() => _SignUpPracticeState();
}

class _SignUpPracticeState extends State<SignUpPractice> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final displayNameController = TextEditingController();
  final notifyController = TextEditingController();
  final passwordController = TextEditingController();

  login(String username, String email, String displayName, String notify,
      String password) async {
    try {
      Response response = await post(
          Uri.parse(
              "https://petvillage.us/api/user/register/?username=sadi&email=sadik@domain.com&nonce=76392b0b51&display_name=sadi&notify=both&user_pass=Test@123"),
          body: {
            "username": username,
            "email": email,
            "nonce": '76392b0b51',
            "display_name":displayName,
            "notify":notify,
            "user_pass":password,


          });

      if(response.statusCode==200){
        var data=jsonDecode(response.body.toString());
        print(data['username']);
        print("account created successful");
      }else{
        print("failed...");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(hintText: "User Name"),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextField(
                controller: displayNameController,
                decoration: InputDecoration(hintText: "Display Name"),
              ),
              TextField(
                controller: notifyController,
                decoration: InputDecoration(hintText: "Notipy"),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "Password"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10)),
                  onPressed: () {
                    login(
                      usernameController.text.toString(),
                      emailController.text.toString(),
                      displayNameController.text.toString(),
                      notifyController.text.toString(),
                      passwordController.text.toString(),
                    );
                  },
                  child: Text("Sign Up"))
            ],
          ),
        ),
      ),
    );
  }
}
