import 'package:flutter/material.dart';
import 'package:users_app/widgets/reuseble_text.dart';

class LoadingDialog extends StatelessWidget {
  final String?message;
  LoadingDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding:const EdgeInsets.only(top: 14),
            child:const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Colors.pinkAccent
              ),
            ),
          ),
          const SizedBox(height: 12,),
          ReusebleText(text: "$message ,Please wait....")
        ],
      ),
    );
  }
}
