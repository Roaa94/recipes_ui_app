import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipes_ui/core/enums/screen_size.dart';
import 'package:recipes_ui/core/styles/app_colors.dart';
import 'package:recipes_ui/core/widgets/fade_in_effect.dart';
import 'package:recipes_ui/features/ingredients/views/widgets/ingredients_section.dart';
import 'package:recipes_ui/features/instructions/views/widgets/instructions_section.dart';
import 'package:recipes_ui/features/recipes/models/recipe.dart';
import 'package:recipes_ui/features/recipes/views/widgets/recipe_page_sidebar.dart';
import 'package:recipes_ui/features/recipes/views/widgets/recipe_page_sliver_app_bar.dart';

class RecipePage extends StatefulWidget {
  const RecipePage(
    this.recipe, {
    Key? key,
    this.initialImageRotationAngle = 0,
  }) : super(key: key);

  final Recipe recipe;
  final double initialImageRotationAngle;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final ScrollController scrollController = ScrollController();
  late final ValueNotifier<double> imageRotationAngleNotifier;

  void scrollListener() {
    ScrollDirection scrollDirection =
        scrollController.position.userScrollDirection;
    double scrollPosition = scrollController.position.pixels.abs();
    if (scrollDirection == ScrollDirection.forward) {
      imageRotationAngleNotifier.value +=
          (scrollPosition * math.pi / 180) * 0.01;
    } else if (scrollDirection == ScrollDirection.reverse) {
      imageRotationAngleNotifier.value -=
          (scrollPosition * math.pi / 180) * 0.01;
    }
  }

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    imageRotationAngleNotifier =
        ValueNotifier<double>(widget.initialImageRotationAngle);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    imageRotationAngleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.recipe.bgColor == AppColors.sugar ? AppColors.yellow : null,
      body: Row(
        children: [
          if (ScreenSize.of(context).isLarge)
            Expanded(
              flex: 1,
              child: ValueListenableBuilder(
                valueListenable: imageRotationAngleNotifier,
                builder: (context, double imageRotationAngle, child) {
                  return RecipePageSidebar(
                    widget.recipe,
                    imageRotationAngle: imageRotationAngle,
                  );
                },
              ),
            ),
          Expanded(
            flex: 1,
            child: CustomScrollView(
              controller: scrollController,
              cacheExtent: 0,
              slivers: [
                if (!ScreenSize.of(context).isLarge)
                  ValueListenableBuilder(
                    valueListenable: imageRotationAngleNotifier,
                    builder: (context, double imageRotationAngle, child) {
                      return RecipePageSliverAppBar(
                        imageRotationAngle: imageRotationAngle,
                        recipe: widget.recipe,
                      );
                    },
                  ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.of(context).isLarge ? 70 : 17,
                    vertical: ScreenSize.of(context).isLarge ? 50 : 20,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Hero(
                        tag: '__recipe_${widget.recipe.id}_title__',
                        child: Text(
                          widget.recipe.title,
                          style: Theme.of(context).textTheme.headline4!,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Hero(
                        tag: '__recipe_${widget.recipe.id}_description__',
                        child: Text(
                          widget.recipe.description,
                          style: Theme.of(context).textTheme.bodyText2!,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInEffect(
                        intervalStart: 0.5,
                        keepAlive: true,
                        child: Text(
                          'INGREDIENTS',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      IngredientsSection(widget.recipe),
                      FadeInEffect(
                        keepAlive: true,
                        child: Text(
                          'STEPS',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      InstructionsSection(widget.recipe),
                    ]),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
