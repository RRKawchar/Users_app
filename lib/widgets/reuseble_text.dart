

import 'package:flutter/material.dart';

class ReusebleText extends StatelessWidget {
  final String text;
  double? fontSize;
  Color? color;
  FontWeight?fontWeight;
  double? letterSpacing;

   ReusebleText({Key? key, required this.text,this.fontSize,this.color,this.fontWeight,this.letterSpacing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: fontSize,color: color,fontWeight: fontWeight,letterSpacing: letterSpacing),);
  }
}
