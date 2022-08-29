import 'package:flutter/material.dart';
import 'package:recipes_ui/core/styles/app_colors.dart';
import 'package:recipes_ui/features/recipes/models/recipe.dart';

class RecipePageImageBg extends StatelessWidget {
  const RecipePageImageBg(
    this.recipe, {
    Key? key,
    required this.borderRadius,
  }) : super(key: key);

  final Recipe recipe;
  final BorderRadius borderRadius;

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
