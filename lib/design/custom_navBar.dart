// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavBarFourItemOnly extends StatelessWidget {
  void Function(int)? onTap;
  int? currentIndex = 0;
  Color? selectedColor;
  Color? unSelectedColor;
  IconData iconNav;
  String textNav;

  CustomNavBarFourItemOnly({
    Key? key,
     this.onTap,
     this.currentIndex,
     this.selectedColor,
     this.unSelectedColor,
    required this.iconNav,
    required this.textNav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: BottomNavigationBar(
          currentIndex: currentIndex!,
          onTap: onTap,
          elevation: 0,
          // selectedLabelStyle: const TextStyle(
          //   color: AppColor.primary,
          // ),
          // unselectedLabelStyle: const TextStyle(
          //   color: AppColor.grey,
          // ),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  iconNav,
                  color: currentIndex == 0 ? selectedColor : unSelectedColor,
                ),
                label: textNav),
            BottomNavigationBarItem(
              icon: Icon(
                iconNav,
                color: currentIndex == 1 ? selectedColor : unSelectedColor,
              ),
              label: textNav,
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  iconNav,
                  color: currentIndex == 3 ? selectedColor : unSelectedColor,
                ),
                label: textNav),
            BottomNavigationBarItem(
                icon: Icon(
                  iconNav,
                  color: currentIndex == 4 ? selectedColor : unSelectedColor,
                ),
                label: textNav),
          ]),
    );
  }
}
