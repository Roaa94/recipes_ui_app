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
      decoration: BoxDecoration(
        color: recipe.bgColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(13),
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: recipe.bgColor,
              shape: BoxShape.circle,
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
            child: Transform.rotate(
              angle: -0.3,
              child: Image.asset(
                'assets/images/chef.png',
                color: AppColors.textColorFromBackground(recipe.bgColor),
              ),
            ),
          ),
          Expanded(
            child: Text(
              ingredient,
              style: Theme.of(context).textTheme.bodyText2!,
            ),
          ),
        ],
      ),
    );
  }
}
