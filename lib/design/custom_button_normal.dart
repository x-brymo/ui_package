// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButtonNormal extends StatelessWidget {
  Widget? child;
  void Function()? tap;
  double? height;
  double? width;
  Color? color;
  double? radius;
  EdgeInsetsGeometry? padding;
  CustomButtonNormal({
    Key? key,
    this.child,
    this.tap,
    this.height,
    this.width,
    this.color,
    this.radius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius!),
        ),
        child: GestureDetector(
          onTap: tap,
          child: child,
        ),
      ),
    );
  }
}
