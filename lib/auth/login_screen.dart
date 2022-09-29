
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/main_screen/home_screen.dart';
import 'package:users_app/splashScreen/splash_screen.dart';
import 'package:users_app/widgets/custom_text_field.dart';
import 'package:users_app/widgets/loading_dialog.dart';
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
  
  validateForm(){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      
      loginNow();
      
    }else{
      Fluttertoast.showToast(msg: "Please provide email and password.");
    }
    
  }

  loginNow()async{
    showDialog(
        context: context,
        builder: (c){
          return LoadingDialog(
            message: "Checking credential",
          );
        }
    );


    User? currentUser;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occured \n $error");
    });

    if(currentUser !=null){

       checkIfUserRecordExist(currentUser!);

    }

  }

  checkIfUserRecordExist(User currentUser)async{

   await FirebaseFirestore.instance.collection("users").
   doc(currentUser.uid).
   get().then((record)async {
     Navigator.push(context, MaterialPageRoute(builder: (c) => SplashScreen()));
       /// record is exist

     if(record.exists){
        /// status is approved
       if(record.data()!['status']=='Approved'){

         await sharedPreferences!.setString("uid", record.data()!['uid']);
         await sharedPreferences!.setString("email", record.data()!['email']);
         await sharedPreferences!.setString("name", record.data()!['name']);
         await sharedPreferences!.setString("photoUrl", record.data()!['photoUrl']);

         List<String> userCartList=record.data()!['userCart'].cost<String>();
         await sharedPreferences!.setStringList('userCart', userCartList);
         // Navigator.pop(context);
         Navigator.push(context, MaterialPageRoute(builder: (c) => SplashScreen()));

       }


       /// status is not approved
       else{
         // FirebaseAuth.instance.signOut();
          Navigator.pop(context);
         Fluttertoast.showToast(msg: "You have ben BLOCKED by admin.\n Contact admin: admin@ishop.com");
       }
     }
     /// Record not exist
     else{
       // FirebaseAuth.instance.signOut();
       Navigator.pop(context);
       Fluttertoast.showToast(msg: "This record is do not exist.");

     }
   });
  }

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
              onPressed: (){
                loginNow();
              },
              child: ReusebleText(text: "Login",fontWeight: FontWeight.bold,color: Colors.white,)
          ),
        ],
      ),
    );
  }
}
