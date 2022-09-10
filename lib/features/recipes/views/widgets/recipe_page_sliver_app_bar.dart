import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipes_ui/core/styles/app_colors.dart';
import 'package:recipes_ui/core/widgets/adaptive_offset_effect.dart';
import 'package:recipes_ui/core/widgets/app_bar_leading.dart';
import 'package:recipes_ui/core/widgets/fade_in_effect.dart';
import 'package:recipes_ui/features/recipes/models/recipe.dart';
import 'package:recipes_ui/features/recipes/views/widgets/recipe_image.dart';
import 'package:recipes_ui/features/recipes/views/widgets/recipe_image_pattern.dart';
import 'package:recipes_ui/features/recipes/views/widgets/recipe_page_image_bg.dart';

class RecipePageSliverAppBar extends StatelessWidget {
  const RecipePageSliverAppBar({
    Key? key,
    required this.recipe,
    this.expandedHeight = 340,
    this.collapsedHeight = 200,
    this.imageRotationAngle = 0,
  }) : super(key: key);

  final Recipe recipe;
  final double expandedHeight;
  final double? collapsedHeight;
  final double imageRotationAngle;

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.7;

    return SliverAppBar(
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      collapsedHeight: collapsedHeight,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: AppColors.getBrightness(recipe.bgColor),
      ),
      leading: AppBarLeading(
        popValue: imageRotationAngle,
        bgColor: AppColors.textColorFromBackground(recipe.bgColor),
      ),
      expandedHeight: expandedHeight + MediaQuery.of(context).padding.top,
      flexibleSpace: AdaptiveOffsetEffect.builder(
        width: MediaQuery.of(context).size.width,
        height: expandedHeight,
        child: RecipePageImageBg(
          recipe,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(35),
            bottomLeft: Radius.circular(35),
          ),
        ),
        childBuilder: (BuildContext context, Offset offset, Widget? child) {
          return Stack(
            children: [
              child!,
              if (recipe.bgImage.isNotEmpty)
                FlexibleSpaceBar(
                  background: FadeInEffect(
                    intervalStart: 0.5,
                    child: Opacity(
                      opacity: 0.6,
                      child: RecipeImagePattern(
                        offset: offset,
                        recipe,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(35),
                          bottomLeft: Radius.circular(35),
                        ),
                      ),
                    ),
                  ),
                ),
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: RecipeImage(
                    recipe,
                    imageRotationAngle: imageRotationAngle,
                    imageSize: imageSize,
                    shadowOffset: offset * 0.6,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
