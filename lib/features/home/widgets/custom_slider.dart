import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final List<String> rasmList = [
    'assets/images/new_1.png',
    'assets/images/new_2.png',
    'assets/images/new_3.png',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: rasmList.map((path) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                path,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 30),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        6.h.verticalSpace,
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rasmList.asMap().entries.map((entry) {
            bool isActive = _currentIndex == entry.key;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: 8,
              width: isActive ? 40 : 8,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryColor : AppColors.unselectedColor,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}