import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vikings/core/styles/app_themes.dart';
import 'package:flutter_vikings/menu/views/pages/menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      title: 'Flutter Vikings Demo',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.main(),
      home: const MenuPage(),
    );
  }
}
