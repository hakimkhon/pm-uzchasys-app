import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uzchasys_app/constants/app_colors.dart';
import '../pages/news_item_page.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final List<Map<String, String>> newsList = [
    {
      'image': 'assets/images/new_1.png',
      'title': 'Yangi ishlab chiqarish liniyasi ishga tushdi',
      'description':
          'UzChasys korxonasida yangi avlod avtomobil faralari ishlab chiqarish liniyasi ishga tushirildi. '
          'Bu loyiha ishlab chiqarish hajmini 25 foizga oshiradi va zamonaviy texnologiyalarni joriy etishga yo‘naltirilgan.',
    },
    {
      'image': 'assets/images/new_2.png',
      'title': 'Xodimlar uchun treninglar boshlandi',
      'description':
          'UzChasys xodimlari uchun maxsus malaka oshirish kurslari boshlandi. '
          'Treninglar xavfsizlik, texnik xizmat va ishlab chiqarish samaradorligini oshirishga bag‘ishlangan.',
    },
    {
      'image': 'assets/images/new_5.png',
      'title': '🌍 UzChasys’da muhim voqea!',
      'description': """
          Korxonamizda xalqaro miqyosda tan olingan IATF sertifikatini beruvchi kompaniya vakillari mehmon bo‘lishdi.

📌 Tekshiruv davomida barcha asosiy jarayonlar — ishlab chiqarish, sotuv, mahsulotlarni qadoqlash, tayyor mahsulot ombori, xarid, rejalashtirish, moliya, yangi loyihalar, ta’minot tizimi, ko‘riklash xizmati va boshqa yo‘nalishlar sinchkovlik bilan o‘rganildi.

👥 Ushbu jarayonda har bir bo‘lim faol qatnashib, o‘z mas’uliyatini amalda ko‘rsatdi. Bu esa UzChasys yagona va kuchli jamoa ekanligini yana bir bor namoyon etdi.

🔧 IATF — bu avtomobilsozlik sohasidagi eng yuqori xalqaro talablarni belgilovchi standart bo‘lib, uning sertifikatiga ega bo‘lish mahsulotlarimizning ishonchliligi va raqobatbardoshligini yanada mustahkamlaydi.

💙 Biz jamoamizning birdamligi, intilishi va fidoyiligi bilan ushbu bosqichni ham muvaffaqiyatli o‘tishimizga ishonamiz.
          """,
    },
    {
      'image': 'assets/images/new_3.png',
      'title': 'Yangi servis markazi ochildi',
      'description':
          'Toshkent shahrida UzChasys servis markazining yangi filiali ishga tushdi. '
          'Endi mijozlar texnik xizmatlardan yanada qulay va tez foydalana oladilar.',
    },
    {
      'image': 'assets/images/new_4.png',
      'title':
          '“UzChasys” qo‘shma korxonasi – 2009-yil 24-sentyabrdan bugungi kunga qadar!',
      'description': """
Bugun korxonamizning asos solinganiga 2009-yil 24-sentyabrdan buyon yillar davomida mehnat, sa’y-harakat va yutuqlarga boy yo‘lini nishonlamoqdamiz.

✨ “UzChasys” jamoasi o‘zining professional tajribasi, mas’uliyati va fidoyiligi bilan korxonamizni yildan-yilga rivojlantirib kelmoqda. Bu nafaqat ishlab chiqarishdagi yutuqlar, balki xalqaro hamkorlik, innovatsion texnologiyalar va eng muhimi — jamoamizning birlik va hamjihatligidir.

🏆 Bayram tadbiri davomida ayrim xodimlarimiz o‘z mehnati va fidoyiligi uchun esdalik sovg‘alari bilan taqdirlandi.

🎁 Shuningdek, qiziqarli lotereya o‘yini o‘tkazilib, xodimlarimizga turli sovg‘alar topshirildi. Bu esa bayram kayfiyatini yanada ko‘tarinki qildi.

📸 Siz bilan kompaniyamiz bayramidan foto-hisobotni baham ko‘ramiz!

🚀 Yangi marralar sari – “UzChasys” bilan birga!
        """,
    },
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: newsList.map((item) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewsItemPage(
                      image: item['image']!,
                      title: item['title']!,
                      description: item['description']!,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  item['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 200.h,
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
          children: newsList.asMap().entries.map((entry) {
            bool isActive = _currentIndex == entry.key;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: 8,
              width: isActive ? 40 : 8,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primaryColor
                    : AppColors.unselectedColor,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
