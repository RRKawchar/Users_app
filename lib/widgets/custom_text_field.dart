import 'package:flutter/material.dart';
import 'package:users_app/utils/colors.dart';

class CustomTextField extends StatefulWidget {


  TextEditingController?textEditingController;
  IconData?iconData;
  String?hintText;
  bool?isObsecure=false;
  bool?isEnable=true;
  CustomTextField({this.textEditingController,this.iconData,this.hintText,this.isObsecure,this.isEnable});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(8.0),
      margin:const EdgeInsets.all(8.0),
      decoration:const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: TextFormField(
        enabled: widget.isEnable,
        controller: widget.textEditingController,
          obscureText: widget.isObsecure!,
          cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            widget.iconData,
            color: purpleAccent,
          ),
          hintText: widget.hintText,
          focusColor: Theme.of(context).primaryColor
        ),
      ),
    );
  }
}
