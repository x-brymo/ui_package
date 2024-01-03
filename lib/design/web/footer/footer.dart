
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  //final int flex;
  final Color? backgroundColor;
  final Alignment? alignment;
  //final double padding;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  const Footer(
      {super.key, this.backgroundColor,
      this.alignment,
      this.padding,
      required this.child});
  @override
  State createState() => FooterState();
}

class FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Colors.grey.shade200,
      child: Align(
        alignment: widget.alignment == null
            ? Alignment.bottomCenter
            : widget.alignment!,
        child: Padding(
          //padding: EdgeInsets.all(widget.padding == null ?5.0:widget.padding),
          padding:
              widget.padding == null ? const EdgeInsets.all(5.0) : widget.padding!,
          child: widget.child,
        ),
      ),
    );
  }
}