import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/features/home/widgets/custom_card_button.dart';
import 'package:uzchasys_app/features/home/widgets/custom_slider.dart';
import 'package:uzchasys_app/features/home/widgets/favotire_services.dart';

import '../../../constants/app_images.dart';
import '../widgets/important_information.dart';

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
                            const BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                            ),
                        ],
                      ),
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        body: SafeArea(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // --- CUSTOM APP BAR ---
                                  Row(
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
                                                decoration: const BoxDecoration(
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
                                  20.h.verticalSpace,
                              
                                  ContentTitle(title: "Yangiliklar"),
                                  const CustomSlider(),
                                  20.h.verticalSpace,
                              
                                  ContentTitle(title: "Muhim ma'lumotlar"),
                                  ImportantInformation(),
                                  20.h.verticalSpace,
                              
                                  ContentTitle(title: "Sevimli xizmatlar"),
                                  FavoriteServices(),
                                ],
                              ),
                            ),
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

class ContentTitle extends StatelessWidget {
  final String title;

  const ContentTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0.w, bottom: 10.h),
      child: Text(
        title,
        style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
