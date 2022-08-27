import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';

class MenuItem {
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String image;
  final String bgImage;
  final Color bgColor;
  final Color textColor;

  MenuItem({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.image,
    required this.bgImage,
    required this.bgColor,
    this.textColor = AppColors.text,
  });
}
