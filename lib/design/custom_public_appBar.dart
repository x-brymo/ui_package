// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../extensions/navigator.dart';

class CustomPublicAppBar extends StatelessWidget {
  String nameBar;
  IconData icon;
  CustomPublicAppBar({
    Key? key,
    required this.nameBar,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
          onTap: () {
            GoInto.pop(context);
            //          Navigator.of(context).popUntil((route){
            //            print("Route ${route}");
            //              if (route is PageRoute<dynamic> && route.settings == null )return true;else{
            //                return false;}
            //          },);

            //          Navigator.popUntil(context,(route)=> route is MaterialPageRoute);
            //        Navigator.of(context).pushReplacementNamed('/home');
            //            Navigator.of(context).popAndPushNamed("/home");
            //          Navigator.of(context).maybePop() ?? Navigator.of(context).pushReplacementNamed('/');
            //          Navigator.of(context).pushReplacementNamed("/");
          },
          child:  Icon(icon)),
      iconTheme: Theme.of(context).iconTheme,
      title: Text(nameBar, style: Theme.of(context).textTheme.titleMedium),
      titleSpacing: -15,
      //            actions: [IconButton()],
      centerTitle: true,
      toolbarOpacity: .98,
      //                bottom: TabBar(),
      //                  ),
    );
  }
}
