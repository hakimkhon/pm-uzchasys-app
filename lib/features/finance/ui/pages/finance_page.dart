import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';

import '../widgets/finance_app_bar.dart';
import '../widgets/finance_card_view.dart';
import '../widgets/finance_toggle.dart';
import '../widgets/page_indicator.dart';
import '../widgets/period_selector.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  bool isMonthly = true;
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  final Map<String, String> monthlyData = {
    '2025 Sentabr': "Sentabr oyi uchun moliyaviy ma’lumotlar...",
    '2025 Avgust': "Avgust oyi uchun moliyaviy ma’lumotlar...",
    '2025 Iyul': "Iyul oyi uchun moliyaviy ma’lumotlar...",
    '2025 Iyun': "Iyun oyi uchun moliyaviy ma’lumotlar...",
    '2025 May': "May oyi uchun moliyaviy ma’lumotlar...",
  };

  final Map<String, String> yearlyData = {
    'Oxirgi 12 oy': "Oxirgi 12 oylik umumiy ma’lumot...",
    '2025-yil': "2025-yil uchun umumiy ma’lumot...",
    '2024-yil': "2024-yil uchun umumiy ma’lumot...",
    '2023-yil': "2023-yil uchun umumiy ma’lumot...",
  };

  @override
  Widget build(BuildContext context) {
    final items = isMonthly ? monthlyData.keys.toList() : yearlyData.keys.toList();
    final dataMap = isMonthly ? monthlyData : yearlyData;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: FinanceAppBar(isMonthly: isMonthly),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            FinanceToggle(
              isMonthly: isMonthly,
              onChanged: (value) {
                setState(() {
                  isMonthly = value;
                  selectedIndex = 0;
                  _pageController.jumpToPage(0);
                });
              },
            ),

            12.h.verticalSpace,

            PeriodSelector(
              items: items,
              selectedIndex: selectedIndex,
              onSelect: (index) {
                setState(() => selectedIndex = index);
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
            ),

            12.h.verticalSpace,

            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: FinanceCardView(
                      controller: _pageController,
                      items: items,
                      dataMap: dataMap,
                      onPageChanged: (index) {
                        setState(() => selectedIndex = index);
                      },
                    ),
                  ),

                  10.h.verticalSpace,

                  PageIndicator(
                    count: items.length,
                    selectedIndex: selectedIndex,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
