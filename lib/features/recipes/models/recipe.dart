import 'package:flutter/material.dart';

class Recipe {
  final int id;
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String image;
  final String bgImageName;
  final Color bgColor;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.image,
    required this.bgImageName,
    required this.bgColor,
  });

  String get bgImage =>
      bgImageName.isEmpty ? '' : 'assets/images/desserts/$bgImageName.png';

  String get bgImageLg =>
      bgImageName.isEmpty ? '' : 'assets/images/desserts/$bgImageName-lg.png';
}
