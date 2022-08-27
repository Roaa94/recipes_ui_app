import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
import 'package:flutter_vikings/features/recipes/models/recipe.dart';

class IngredientItem extends StatelessWidget {
  const IngredientItem(
    this.recipe, {
    Key? key,
    required this.ingredient,
  }) : super(key: key);

  final Recipe recipe;
  final String ingredient;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: recipe.bgColor,
        borderRadius: BorderRadius.circular(20),
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
      child: Text(
        ingredient,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppColors.textColorFromBackground(recipe.bgColor),
            ),
      ),
    );
  }
}
