import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

class CustomNavItem extends BottomNavigationBarItem {
  CustomNavItem({
    required IconData icon,
    required String label,
    Color? activeColor,
    double iconSize = 26,
    double activeIconSize = 29,
  }) : super(
         icon: Icon(icon, size: iconSize),
         activeIcon: Icon(
           icon,
           size: activeIconSize,
           color: activeColor ?? AppColors.primaryColor,
         ),
         label: label,
       );
}
