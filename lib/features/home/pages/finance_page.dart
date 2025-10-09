import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import 'package:uzchasys_app/features/home/widgets/custom_card_button.dart';

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
    '2026 May': "May oyi uchun moliyaviy ma’lumotlar...",
  };

  final Map<String, String> yearlyData = {
    'Oxirgi 12 oy': "Oxirgi 12 oylik umumiy ma’lumot...",
    '2025-yil': "2025-yil uchun umumiy ma’lumot...",
    '2024-yil': "2024-yil uchun umumiy ma’lumot...",
    '2023-yil': "2023-yil uchun umumiy ma’lumot...",
  };

  @override
  Widget build(BuildContext context) {
    final items = isMonthly
        ? monthlyData.keys.toList()
        : yearlyData.keys.toList();
    final dataMap = isMonthly ? monthlyData : yearlyData;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Moliyaviy ma'lumotlar"),
        backgroundColor: AppColors.white,
        titleTextStyle: TextStyle(
          color: AppColors.secondaryColor,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          if (!isMonthly)
            CustomCardButton(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Yillik ma’lumot yuklanmoqda...'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(16),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  
                );
              },
              child: Icon(Icons.download, size: 28.sp, color: AppColors.primaryColor),
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            // 1. Oylik / Yillik toggle
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMonthly = true;
                          selectedIndex = 0;
                          _pageController.jumpToPage(0);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isMonthly
                              ? AppColors.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Oylik',
                          style: TextStyle(
                            color: isMonthly ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMonthly = false;
                          selectedIndex = 0;
                          _pageController.jumpToPage(0);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: !isMonthly
                              ? AppColors.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Yillik',
                          style: TextStyle(
                            color: !isMonthly ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            12.h.verticalSpace,

            // 2. Oy / Yil tanlash tugmalari
            SizedBox(
              height: 36.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedIndex = index);
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            items[index],
                            style: TextStyle(
                              color:
                                  isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            12.h.verticalSpace,

            // 3. Card ichida PageView bilan surish
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: items.length,
                        onPageChanged: (index) {
                          setState(() => selectedIndex = index);
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Scrollbar(
                              thumbVisibility: true,
                              radius: const Radius.circular(8),
                              child: SingleChildScrollView(
                                child: Text(
                                  dataMap[items[index]]!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  10.h.verticalSpace,

                  // 4. Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(items.length, (index) {
                      final isActive = index == selectedIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: isActive ? 40 : 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primaryColor
                              : Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }),
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
