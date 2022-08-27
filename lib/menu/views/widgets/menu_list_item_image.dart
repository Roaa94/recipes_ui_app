import 'package:flutter/material.dart';
import 'package:flutter_vikings/menu/food_menu_layout.dart';
import 'package:flutter_vikings/menu/models/food_menu_item.dart';
import 'package:flutter_vikings/menu/views/widgets/menu_list_item_image_wrapper.dart';

class MenuListItemImage extends StatelessWidget {
  const MenuListItemImage(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final FoodMenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    double imageSize = FoodMenuLayout.of(context).menuItemImageSize;

    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: Stack(
        children: [
          Positioned(
            bottom: -20,
            right: -20,
            child: MenuListItemImageWrapper(
              child: Image.asset(
                menuItem.image,
                width: imageSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
