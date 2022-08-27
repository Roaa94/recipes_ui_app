import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vikings/core/enums/screen_size.dart';
import 'package:flutter_vikings/recipes/models/recipe.dart';
import 'package:flutter_vikings/recipes/views/widgets/recipe_page_sidebar.dart';
import 'package:flutter_vikings/recipes/views/widgets/recipe_page_sliver_app_bar.dart';

class RecipePage extends StatefulWidget {
  const RecipePage(
    this.recipe, {
    Key? key,
  }) : super(key: key);

  final Recipe recipe;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<double> imageRotationAngleNotifier =
      ValueNotifier<double>(0);

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
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              slivers: [
                if (!ScreenSize.of(context).isLarge)
                  ValueListenableBuilder(
                    valueListenable: imageRotationAngleNotifier,
                    builder: (context, double imageRotationAngle, child) {
                      return RecipePageSliderAppBar(
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
                    ]),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 1000,
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
