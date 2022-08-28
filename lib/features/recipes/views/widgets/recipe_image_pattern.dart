import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/enums/screen_size.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
import 'package:flutter_vikings/core/widgets/gyroscope_or_pointer_effect.dart';
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
    String bgImage =
        ScreenSize.of(context).isLarge ? recipe.bgImageLg : recipe.bgImage;
    AlignmentGeometry alignment = ScreenSize.of(context).isLarge
        ? Alignment.center
        : Alignment.bottomCenter;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GyroscopeOrPointerEffect(
          offsetMultiplier: 1.5,
          maxMovableDistance: 12,
          child: Align(
            alignment: alignment,
            child: ClipRRect(
              borderRadius: borderRadius,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
                child: Image.asset(
                  bgImage,
                  color: AppColors.orangeDark.withOpacity(0.5),
                  alignment: alignment,
                ),
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
                  image: AssetImage(bgImage),
                  alignment: alignment,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
