import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/main_screen/home_screen.dart';
import 'package:users_app/widgets/custom_text_field.dart';
import 'package:users_app/widgets/loading_dialog.dart';
import 'package:users_app/widgets/reuseble_text.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  XFile? imgXFile;

  final ImagePicker imagePicker = ImagePicker();

  String downloadUrlImge = "";

  /// Pic Image from gallery
  getImageFromGallery() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgXFile;
    });
  }

  formValidation() async {
    if (imgXFile == null) {
      Fluttertoast.showToast(msg: "Please select an image.");
    } else {
      if (passwordController.text == confirmPassController.text) {
        if (nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            confirmPassController.text.isNotEmpty) {
          showDialog(
              context: context,
              builder: (c) {
                return LoadingDialog(
                  message: "Registering your account",
                );
              });

          /// Save Image Firebase Storage
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance
              .ref()
              .child('usersImages')
              .child(fileName);
          fStorage.UploadTask uploadTask =
              reference.putFile(File(imgXFile!.path));
          fStorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          taskSnapshot.ref.getDownloadURL().then((imageUrl) {
            downloadUrlImge = imageUrl;
          });

          ///Here Authentication method

          authentication();
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Please complete the form.");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Password and confirm Password do not match.");
      }
    }
  }

  ///Create Sign Up Authentication
  authentication() async {
    User? currentUser;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occured \n $error");
    });

    if (currentUser != null) {
      saveInfoToFirstoreAndLocally(currentUser!);
    }
  }

  saveInfoToFirstoreAndLocally(User currentUser) async {
    /// Save to Firestore

    FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
      "uid": currentUser.uid,
      "email": currentUser.email,
      "name": nameController.text.trim(),
      "photoUrl": downloadUrlImge,
      "status": "Approved",
      "userCart": ["initialValue"]
    });

    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email!);
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", downloadUrlImge);
    await sharedPreferences!.setStringList("userCart", ["initialValue"]);

    Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                getImageFromGallery();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage:
                    imgXFile == null ? null : FileImage(File(imgXFile!.path)),
                child: imgXFile != null
                    ? null
                    : Icon(
                        Icons.add_photo_alternate,
                        color: Colors.grey,
                        size: MediaQuery.of(context).size.width * 0.20,
                      ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Form(
                key: globalKey,
                child: Column(
                  children: [
                    CustomTextField(
                      textEditingController: nameController,
                      iconData: Icons.person,
                      isObsecure: false,
                      isEnable: true,
                      hintText: "Name",
                    ),
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
                    CustomTextField(
                      textEditingController: confirmPassController,
                      iconData: Icons.lock,
                      isObsecure: true,
                      isEnable: true,
                      hintText: "Confirm Password",
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12)),
                onPressed: () {
                  formValidation();
                },
                child: ReusebleText(
                  text: "Sign UP",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
