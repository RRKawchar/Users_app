import 'package:flutter/material.dart';
import 'package:users_app/widgets/reuseble_text.dart';

class ErrorMessage extends StatelessWidget {
  final String? message;
  ErrorMessage({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       alignment: Alignment.center,
      key: key,
      content: Column(
        children: [
          ReusebleText(text: "$message , please wait..."),

        ],
      ),
    );
  }
}
