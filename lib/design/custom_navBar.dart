// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavBarFourItemOnly extends StatelessWidget {
  final void Function(int)? onTap;
  final int? currentIndex ;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final IconData iconNav;
  final String textNav;

  const CustomNavBarFourItemOnly({
    Key? key,
    this.onTap,
    this.selectedColor,
    this.unSelectedColor,
    required this.iconNav,
    required this.textNav, this.currentIndex =0,
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
