import 'package:flutter/material.dart';
import 'package:uzchasys_app/core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/widgets/app_bar_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Sozlamalar",
        backRouteName: AppRoutesNames.home,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Tilni o‘zgartirish"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Bildirishnomalar"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text("Xavfsizlik"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
