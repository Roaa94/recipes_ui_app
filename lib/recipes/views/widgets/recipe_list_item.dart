import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
import 'package:flutter_vikings/recipes/models/recipe.dart';
import 'package:flutter_vikings/recipes/views/pages/recipe_page.dart';
import 'package:flutter_vikings/recipes/views/widgets/recipe_list_item_image.dart';
import 'package:flutter_vikings/recipes/views/widgets/recipe_list_item_text.dart';

class RecipeListItem extends StatelessWidget {
  const RecipeListItem(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final Recipe menuItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return RecipePage(menuItem);
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
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: 170,
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: '__recipe_${menuItem.id}_image_bg__',
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    color: menuItem.bgColor,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.orangeDark.withOpacity(
                          AppColors.getBrightness(menuItem.bgColor) ==
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
                child: RecipeListItemImage(menuItem),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: RecipeListItemText(menuItem),
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
