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
