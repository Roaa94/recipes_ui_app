import 'package:flutter/material.dart';
import 'package:flutter_vikings/features/recipes/models/recipe.dart';

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
    return Stack(
      children: [
        // Positioned.fill(
        //   child: Container(
        //     decoration: BoxDecoration(
        //
        //     ),
        //   ),
        // ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Hero(
                tag: '__recipe_${recipe.id}_image__',
                // Todo: MAYBE add a TweenAnimationBuilder for smoother animation??
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
        ),
      ],
    );
  }
}
