import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recipe.ingredients.length,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: recipe.bgColor,
          ),
          child: Text(recipe.ingredients[i]),
        );
      },
    );
  }
}
