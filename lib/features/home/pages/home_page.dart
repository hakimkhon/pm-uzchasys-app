import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../widgets/custom_nav_item.dart';
import 'main_page.dart';
import 'finance_page.dart';
import 'service_page.dart';
import 'document_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          MainPage(),
          FinancePage(),
          ServicePage(),
          DocumentPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white, // oq fon
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white, // fon oq
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.unselectedColor,
            selectedLabelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            items: [
              CustomNavItem(icon: Icons.home_outlined, label: 'Asosiy'),
              CustomNavItem(icon: Icons.bar_chart_outlined, label: 'Finance'),
              CustomNavItem(icon: Icons.grid_view_outlined, label: 'Service'),
              CustomNavItem(icon: Icons.picture_as_pdf_outlined, label: 'Xujjat'),
              CustomNavItem(icon: Icons.person_outline, label: 'Profil'),
            ],
          ),
        ),
      ),
    );
  }
}
