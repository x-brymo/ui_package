import 'package:flutter/material.dart';

class GoInto {
  //static void go(BuildContext context, Widget page) => Navigator
  //      .pushReplacementNamed(context, '/${page.runtimeType}');
  //    MaterialPageRoute(builder: (context)=>page);
  //        CupertinoPageRoute(builder:(context)=>page));
  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void goName(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static void goByRout(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  static void popUn(BuildContext context) {
    Navigator.popUntil(context, (route) => false);
  }

  static void goo(BuildContext context, Widget page) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => page);
    Navigator.push(context, route);
  }

  static void goNamedAndRemove(BuildContext context,String newRouteName) {
    Navigator.pushNamedAndRemoveUntil(context, newRouteName, (route) => false);
  }
}
