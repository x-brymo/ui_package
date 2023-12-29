// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButtonNormal extends StatelessWidget {
  final Widget? child;
  final void Function()? tap;
  final double? height;
  final double? width;
  final Color? color;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  const CustomButtonNormal({
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
