// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final String image;
  final Color? color;
  final double? hei;
  final double? wd;
  const SplashScreen({
    Key? key,
    required this.image,
    required this.color,
    this.hei,
    this.wd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child:
                Image.asset(image, fit: BoxFit.cover, width: wd, height: hei)),
        CircularProgressIndicator(
          color: color,
        )
      ],
    );
  }
}
