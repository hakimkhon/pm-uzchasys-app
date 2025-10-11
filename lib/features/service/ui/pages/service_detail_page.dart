import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/features/home/ui/widgets/custom_card_button.dart';
import 'package:uzchasys_app/global/widgets/app_bar_widget.dart';

import '../../../../constants/app_colors.dart';

class ServiceDetailPage extends StatefulWidget {
  final Map<String, String> service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() => isFavorite = !isFavorite);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? 'Sevimli xizmatlarga qo‘shildi'
              : 'Sevimli xizmatlardan o‘chirildi',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.service['title'] ?? '';

    return Scaffold(
      backgroundColor: AppColors.detailPage,
      appBar: AppBarWidget(
        title: title,
        titleSize: 24.sp,
        actionWidget: CustomCardButton(
          onTap: toggleFavorite,
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.orange : Colors.grey,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '$title haqida ma’lumot bu yerda joylashadi.\n\n'
          'Hozircha bu sahifa xizmatga oid namunaviy matn sifatida xizmat qiladi.',
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }
}
