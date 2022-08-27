import 'package:flutter/material.dart';
import 'package:flutter_vikings/recipes/recipes_layout.dart';
import 'package:flutter_vikings/recipes/models/recipe.dart';
import 'package:flutter_vikings/recipes/views/widgets/recipe_list_item_image_wrapper.dart';

class RecipeListItemImage extends StatelessWidget {
  const RecipeListItemImage(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final Recipe menuItem;

  @override
  Widget build(BuildContext context) {
    double imageSize = RecipesLayout.of(context).menuItemImageSize;

    return RecipeListItemImageWrapper(
      child: Hero(
        tag: '__recipe_${menuItem.id}_image__',
        child: Image.asset(
          menuItem.image,
          width: imageSize,
        ),
      ),
    );
  }
}
