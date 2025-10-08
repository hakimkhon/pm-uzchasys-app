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
  int _previousIndex = 0;

  final List<Widget> _pages = const [
    MainPage(),
    FinancePage(),
    ServicePage(),
    DocumentPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
    });
  }

  // transition builder uses current _selectedIndex and _previousIndex
  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    // detect incoming child
    final isIncoming = (child.key == ValueKey(_selectedIndex));
    final direction = (_selectedIndex >= _previousIndex) ? 1.0 : -1.0;

    final Tween<Offset> tweenIn = Tween(begin: Offset(direction, 0), end: Offset.zero);
    final Tween<Offset> tweenOut = Tween(begin: Offset.zero, end: Offset(-direction, 0));

    final Animation<Offset> position = isIncoming
        ? animation.drive(tweenIn.chain(CurveTween(curve: Curves.easeInOut)))
        : ReverseAnimation(animation).drive(tweenOut.chain(CurveTween(curve: Curves.easeInOut)));

    return SlideTransition(
      position: position,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: _transitionBuilder,
          child: _pages[_selectedIndex], // ensure each page has unique ValueKey inside
        ),
      ),

      // rounded white bottom bar with shadow
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, -3))],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.background,
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.unselectedColor,
            selectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            items: [
              CustomNavItem(icon: Icons.home_outlined, label: 'Asosiy'),
              CustomNavItem(icon: Icons.bar_chart_outlined, label: 'Moliya'),
              CustomNavItem(icon: Icons.grid_view_outlined, label: 'Xizmatlar'),
              CustomNavItem(icon: Icons.picture_as_pdf_outlined, label: 'Hujjatlar'),
              CustomNavItem(icon: Icons.person_outline, label: 'Profil'),
            ],
          ),
        ),
      ),
    );
  }
}
