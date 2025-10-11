import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/favotire_services.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/section_title.dart';
import '../widgets/custom_slider.dart';
import '../widgets/important_information.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _scaleAnimation = Tween<double>(begin: 1, end: 0.85).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.6, 0)).animate(_controller);
  }

  void toggleDrawer() {
    setState(() {
      isDrawerOpen ? _controller.reverse() : _controller.forward();
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
        const CustomDrawer(),

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
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: SafeArea(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainAppBar(onMenuTap: toggleDrawer),
                              20.h.verticalSpace,

                              const SectionTitle(title: "Yangiliklar"),
                              const CustomSlider(),
                              20.h.verticalSpace,

                              const SectionTitle(title: "Muhim ma'lumotlar"),
                              ImportantInformation(),
                              20.h.verticalSpace,

                              const SectionTitle(title: "Sevimli xizmatlar"),
                              FavoriteServices(),
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
}
