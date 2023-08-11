import 'package:flutter/material.dart';

class CustomButtonNormal extends StatelessWidget {
  double? btnh;
  double? btnw;
  String? text;
  Color? color = Colors.white70 ;
  void Function()? onTap;
  CustomButtonNormal({this.btnh, this.text, this.onTap});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(),
    );
  }
}
