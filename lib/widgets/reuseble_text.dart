

import 'package:flutter/material.dart';

class ReusebleText extends StatelessWidget {
  final String text;
  double? fontSize;
  Color? color;
  FontWeight?fontWeight;

   ReusebleText({Key? key, required this.text,this.fontSize,this.color,this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: fontSize,color: color,fontWeight: fontWeight),);
  }
}
