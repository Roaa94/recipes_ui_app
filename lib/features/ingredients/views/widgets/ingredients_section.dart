import 'package:flutter/material.dart';
import 'package:flutter_vikings/features/ingredients/views/widgets/ingredient_item.dart';
import 'package:flutter_vikings/features/ingredients/views/widgets/ingredient_item_wrapper.dart';
import 'package:flutter_vikings/features/recipes/models/recipe.dart';

class IngredientsSection extends StatelessWidget {
  const IngredientsSection(
    this.recipe, {
    Key? key,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recipe.ingredients.length,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return IngredientItemWrapper(
          index: i,
          totalCount: recipe.ingredients.length,
          child: IngredientItem(
            recipe,
            ingredient: recipe.ingredients[i],
          ),
        );
      },
    );
  }
}
