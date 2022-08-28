import 'package:flutter/material.dart';
import 'package:flutter_vikings/features/recipes/models/recipe.dart';

class RecipeImage extends StatelessWidget {
  const RecipeImage(
    this.recipe, {
    Key? key,
    this.imageRotationAngle = 0,
    this.imageSize,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final Recipe recipe;
  final double imageRotationAngle;
  final double? imageSize;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Hero(
        tag: '__recipe_${recipe.id}_image__',
        // Todo: MAYBE add a TweenAnimationBuilder for smoother animation??
        child: Transform.rotate(
          angle: imageRotationAngle,
          child: Image.asset(
            recipe.image,
            width: imageSize,
          ),
        ),
      ),
    );
  }
}
