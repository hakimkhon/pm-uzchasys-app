import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/features/home/widgets/custom_card_button.dart';

import '../../../constants/app_images.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.85).animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.6, 0),
    ).animate(_controller);
  }

  void toggleDrawer() {
    setState(() {
      if (isDrawerOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isDrawerOpen = !isDrawerOpen;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // --- DRAWER PANEL ---
        Container(
          width: 250.w,
          color: Colors.blue.shade700,
          padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mening profilim",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              30.h.verticalSpace,
              drawerItem(Icons.person, "Profil"),
              drawerItem(Icons.settings, "Sozlamalar"),
              drawerItem(Icons.logout, "Chiqish"),
            ],
          ),
        ),

        // --- ASOSIY SAHIFA ---
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onTap: () {
                    if (isDrawerOpen) toggleDrawer();
                  },
                  child: AbsorbPointer(
                    absorbing: isDrawerOpen,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: isDrawerOpen
                            ? BorderRadius.circular(20.r)
                            : BorderRadius.zero,
                        boxShadow: [
                          if (isDrawerOpen)
                            BoxShadow(color: Colors.black26, blurRadius: 20),
                        ],
                      ),
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        body: SafeArea(
                          child: Column(
                            children: [
                              // --- CUSTOM APP BAR ---
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 10.h,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomCardButton(
                                      onTap: toggleDrawer,
                                      child: Icon(Icons.menu, size: 30.sp),
                                    ),
                                   
                                    Image(
                                      height: 70.h,
                                      image: AssetImage(AppImages.carLogo),
                                    ),
                                    CustomCardButton(
                                      onTap: () {},
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Icon(
                                            Icons.notifications_none,
                                            size: 30.sp,
                                          ),
                                          Positioned(
                                            right: -11,
                                            top: -11,
                                            child: Container(
                                              padding: EdgeInsets.all(6.r),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                "9",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // --- BODY CONTENT ---
                             Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: AssetImage(AppImages.malumotlarOynasi),
                                ),
                                20.h.verticalSpace,
                                Text(
                                  "Ma'lumotlar oynasi",
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                10.h.verticalSpace,
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Text(
                                    "Bu yerda siz o'zingizning barcha ma'lumotlaringizni ko'rishingiz mumkin. Har qanday savol yoki muammolar bo'lsa, biz bilan bog'laning.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ],
                             )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget drawerItem(IconData icon, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          12.w.horizontalSpace,
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
