import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class CustomNavItem extends BottomNavigationBarItem {
  CustomNavItem({
    required IconData icon,
    required String label,
    Color? activeColor,
    double iconSize = 28,
    double fontSize = 14,
  }) : super(
          icon: Icon(icon, size: iconSize),
          activeIcon: Icon(
            icon,
            size: iconSize + 3,
            color: activeColor ?? AppColors.primaryColor,
          ),
          label: label,
        );
}
