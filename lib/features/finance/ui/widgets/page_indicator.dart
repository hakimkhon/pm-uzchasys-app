import 'package:flutter/material.dart';
import 'package:uzchasys_app/constants/app_colors.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int selectedIndex;

  const PageIndicator({
    super.key,
    required this.count,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == selectedIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: isActive ? 40 : 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryColor : Colors.grey[400],
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
