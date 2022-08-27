import 'package:flutter/material.dart';
import 'package:flutter_vikings/recipes/models/recipe.dart';
import 'package:flutter_vikings/recipes/views/widgets/recipe_page_sliver_app_bar.dart';

class RecipePage extends StatelessWidget {
  const RecipePage(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final Recipe menuItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          FoodItemSliverAppBar(
            menuItem: menuItem,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Hero(
                  tag: '__recipe_${menuItem.id}_title__',
                  child: Text(
                    menuItem.title,
                    style: Theme.of(context).textTheme.headline4!,
                  ),
                ),
                const SizedBox(height: 10),
                Hero(
                  tag: '__recipe_${menuItem.id}_description__',
                  child: Text(
                    menuItem.description,
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
    );
  }
}
