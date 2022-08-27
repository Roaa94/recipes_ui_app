import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
import 'package:flutter_vikings/recipes/models/recipe.dart';

class RecipePageImageBg extends StatelessWidget {
  const RecipePageImageBg(
    this.recipe, {
    Key? key,
    required this.borderRadius,
  }) : super(key: key);

  final Recipe recipe;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '__recipe_${recipe.id}_image_bg__',
      child: Container(
        decoration: BoxDecoration(
          color: recipe.bgColor,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: AppColors.orangeDark.withOpacity(
                AppColors.getBrightness(recipe.bgColor) == Brightness.dark
                    ? 0.5
                    : 0.2,
              ),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
