
import 'package:flutter/material.dart';
import 'package:users_app/widgets/custom_text_field.dart';
import 'package:users_app/widgets/reuseble_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  GlobalKey<FormState> globalKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset("images/login.png",
            height: MediaQuery.of(context).size.height*0.30,
            ),
          ),

          Form(
              key: globalKey,

              child: Column(
                children: [

                  CustomTextField(
                    textEditingController: emailController,
                    iconData: Icons.email,
                    isObsecure: false,
                    isEnable: true,
                    hintText: "Email",
                  ),
                  CustomTextField(
                    textEditingController: passwordController,
                    iconData: Icons.lock,
                    isObsecure: true,
                    isEnable: true,
                    hintText: "Password",
                  ),

                  const SizedBox(height: 10,)
                ],
              )
          ),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding:const EdgeInsets.symmetric(horizontal: 50,vertical: 12)
              ),
              onPressed: (){},
              child: ReusebleText(text: "Login",fontWeight: FontWeight.bold,color: Colors.white,)
          ),
        ],
      ),
    );
  }
}
