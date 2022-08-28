import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
import 'package:flutter_vikings/features/ingredients/views/widgets/gyroscope_or_pointer_effect.dart';
import 'package:flutter_vikings/features/recipes/models/recipe.dart';

class RecipeImagePattern extends StatelessWidget {
  const RecipeImagePattern(
    this.recipe, {
    Key? key,
    required this.borderRadius,
  }) : super(key: key);

  final Recipe recipe;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GyroscopeOrPointerEffect(
          offsetMultiplier: 1.5,
          child: ClipRRect(
            borderRadius: borderRadius,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
              child: Image.asset(
                recipe.bgImage,
                color: AppColors.orangeDark.withOpacity(0.5),
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        GyroscopeOrPointerEffect(
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(recipe.bgImage),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
