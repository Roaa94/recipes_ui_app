import 'package:flutter/material.dart';
import 'package:recipes_ui/core/enums/screen_size.dart';

class RecipesLayout {
  final BuildContext context;

  RecipesLayout(this.context);

  static RecipesLayout of(BuildContext context) {
    return RecipesLayout(context);
  }

  int get gridCrossAxisCount {
    switch (ScreenSize.of(context)) {
      case ScreenSize.xs:
      case ScreenSize.sm:
        return 1;
      case ScreenSize.md:
        return 2;
      case ScreenSize.lg:
      case ScreenSize.xl:
      case ScreenSize.xxl:
        return 3;
    }
  }

  double get gridChildAspectRatio {
    switch (ScreenSize.of(context)) {
      case ScreenSize.xs:
      case ScreenSize.sm:
        return 1.5;
      case ScreenSize.md:
        return 2;
      case ScreenSize.lg:
        return 1.5;
      case ScreenSize.xl:
        return 1.5;
      case ScreenSize.xxl:
        return 1.5;
    }
  }

  double get recipeImageSize {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.45 / gridCrossAxisCount;
  }
}
