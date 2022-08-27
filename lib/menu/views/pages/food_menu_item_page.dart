import 'package:flutter/material.dart';
import 'package:flutter_vikings/menu/models/food_menu_item.dart';
import 'package:flutter_vikings/menu/views/widgets/food_item_sliver_app_bar.dart';

class FoodMenuItemPage extends StatelessWidget {
  const FoodMenuItemPage(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final FoodMenuItem menuItem;

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
                  tag: '__food_item_${menuItem.id}_title__',
                  child: Text(
                    menuItem.title,
                    style: Theme.of(context).textTheme.headline4!,
                  ),
                ),
                const SizedBox(height: 10),
                Hero(
                  tag: '__food_item_${menuItem.id}_description__',
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
