import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/enums/screen_size.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
import 'package:flutter_vikings/features/recipes/models/recipe.dart';
import 'package:flutter_vikings/features/recipes/views/pages/recipe_page.dart';
import 'package:flutter_vikings/features/recipes/views/widgets/recipe_list_item_gesture_detector.dart';
import 'package:flutter_vikings/features/recipes/views/widgets/recipe_list_item_image.dart';
import 'package:flutter_vikings/features/recipes/views/widgets/recipe_list_item_text.dart';

class RecipeListItem extends StatefulWidget {
  const RecipeListItem(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final Recipe menuItem;

  @override
  State<RecipeListItem> createState() => _RecipeListItemState();
}

class _RecipeListItemState extends State<RecipeListItem> {
  double recipeImageRotationAngle = 0;

  @override
  Widget build(BuildContext context) {
    return RecipeListItemGestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return RecipePage(
                widget.menuItem,
                initialImageRotationAngle: recipeImageRotationAngle,
              );
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        )
            .then((response) {
          if (response != null && response is double) {
            setState(() {
              recipeImageRotationAngle = response;
            });
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.of(context).isLarge ? 15 : 12.5),
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: '__recipe_${widget.menuItem.id}_image_bg__',
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    color: widget.menuItem.bgColor,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.orangeDark.withOpacity(
                          AppColors.getBrightness(widget.menuItem.bgColor) ==
                                  Brightness.dark
                              ? 0.5
                              : 0.2,
                        ),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  // child: RecipeListItemImage(menuItem),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.bottomRight,
                child: RecipeListItemImage(
                  widget.menuItem,
                  imageRotationAngle: recipeImageRotationAngle,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: RecipeListItemText(widget.menuItem),
                ),
                Expanded(flex: 2, child: Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
