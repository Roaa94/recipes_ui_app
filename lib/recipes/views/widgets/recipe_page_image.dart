import 'package:flutter/material.dart';
import 'package:flutter_vikings/recipes/models/recipe.dart';

class RecipePageImage extends StatelessWidget {
  const RecipePageImage(
    this.recipe, {
    Key? key,
    this.imageRotationAngle = 0,
  }) : super(key: key);

  final Recipe recipe;
  final double imageRotationAngle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Hero(
            tag: '__recipe_${recipe.id}_image__',
            child: Transform.rotate(
              angle: imageRotationAngle,
              child: Image.asset(
                recipe.image,
                width: MediaQuery.of(context).size.width * 0.75,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
