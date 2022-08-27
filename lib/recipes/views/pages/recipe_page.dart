import 'package:flutter/material.dart';
import 'package:flutter_vikings/recipes/models/recipe.dart';
import 'package:flutter_vikings/recipes/views/widgets/recipe_page_sliver_app_bar.dart';

class RecipePage extends StatefulWidget {
  const RecipePage(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final Recipe menuItem;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          FoodItemSliverAppBar(
            scrollController: scrollController,
            menuItem: widget.menuItem,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Hero(
                  tag: '__recipe_${widget.menuItem.id}_title__',
                  child: Text(
                    widget.menuItem.title,
                    style: Theme.of(context).textTheme.headline4!,
                  ),
                ),
                const SizedBox(height: 10),
                Hero(
                  tag: '__recipe_${widget.menuItem.id}_description__',
                  child: Text(
                    widget.menuItem.description,
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
