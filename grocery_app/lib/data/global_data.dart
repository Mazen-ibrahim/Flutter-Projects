import 'package:flutter/material.dart';
import 'package:shop_app/widgets/add_item.dart';
import 'package:shop_app/widgets/analysis.dart';
import 'package:shop_app/widgets/dashboard.dart';

final ThemeData groceryTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFFD9F0E1),
  primaryColor: Color(0xFF4CAF81),
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(255, 117, 230, 173),
    foregroundColor: Colors.black,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Color(0xFF4CAF81),
    secondary: Color(0xFF2D6A4F),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF2D6A4F)),
    bodyMedium: TextStyle(color: Color(0xFF2D6A4F)),
  ),
);

final List<Widget> pages = [
  Dashboard(),
  AddItem(),
  Analysis(),
];
