import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
import 'package:flutter_vikings/features/recipes/models/recipe.dart';

class RecipeImage extends StatelessWidget {
  const RecipeImage(
    this.recipe, {
    Key? key,
    this.imageRotationAngle = 0,
    this.imageSize,
    this.alignment = Alignment.center,
    this.isShadowMovable = false,
  }) : super(key: key);

  final Recipe recipe;
  final double imageRotationAngle;
  final double? imageSize;
  final AlignmentGeometry alignment;
  final bool isShadowMovable;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Hero(
        tag: '__recipe_${recipe.id}_image__',
        // Todo: MAYBE add a TweenAnimationBuilder for smoother animation??
        child: SizedBox(
          width: imageSize,
          height: imageSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                clipBehavior: Clip.none,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.orangeDark.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Transform.rotate(
                  angle: imageRotationAngle,
                  child: Image.asset(
                    recipe.image,
                    width: imageSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
