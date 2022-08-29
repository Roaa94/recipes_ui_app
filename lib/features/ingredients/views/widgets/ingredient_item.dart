import 'package:flutter/material.dart';
import 'package:recipes_ui/core/styles/app_colors.dart';
import 'package:recipes_ui/features/recipes/models/recipe.dart';

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
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: recipe.bgColor, width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(0, -10),
            child: Container(
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
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    ingredient,
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
