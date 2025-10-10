import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';

class FinanceToggle extends StatelessWidget {
  final bool isMonthly;
  final ValueChanged<bool> onChanged;

  const FinanceToggle({
    super.key,
    required this.isMonthly,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          _buildButton('Oylik', isMonthly, true),
          _buildButton('Yillik', !isMonthly, false),
        ],
      ),
    );
  }

  Expanded _buildButton(String text, bool isActive, bool value) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
