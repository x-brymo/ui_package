// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFelid extends StatelessWidget {
  TextEditingController? controller;
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  String? hintTexts;
  double? h;
  double? w;
  Color? colorBorderSide;
  CustomTextFelid({
    Key? key,
    this.controller,
    this.validator,
    this.onChanged,
    this.hintTexts,
    this.h,
    this.w,
    this.colorBorderSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,
      width: w,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintTexts,
          enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: colorBorderSide!, width: 0.3)),
          focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: colorBorderSide!, width: 0.3)),
        ),
        controller: controller,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
