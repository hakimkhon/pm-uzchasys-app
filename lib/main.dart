import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Status bar rang va ikonka rangini sozlash
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // fon rangi
      statusBarIconBrightness:
          Brightness.light, // iconlar rangi (dark = qora, light = oq)
    ),
  );
  runApp(const App());
}