import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/global/widgets/app_bar_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Notifications", titleSize: 24.sp,),
      body: Center(child: Text("Barcha Bildirishnomalar shu joyda"),),
    );
  }
}