import 'package:flutter/material.dart';

enum Categories {
  dairy,
  fruit,
  meat,
  vegetables,
  bakery,
  beverages,
  snacks,
  household,

}

class Category {
  final String title;
  final Color color;

  const Category({required this.title, required this.color});

}
