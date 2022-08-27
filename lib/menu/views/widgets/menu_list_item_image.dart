import 'package:flutter/material.dart';
import 'package:flutter_vikings/menu/models/food_menu_item.dart';

class MenuListItemImage extends StatefulWidget {
  const MenuListItemImage(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final FoodMenuItem menuItem;

  @override
  State<MenuListItemImage> createState() => _MenuListItemImageState();
}

class _MenuListItemImageState extends State<MenuListItemImage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: Stack(
        children: [
          Positioned(
            bottom: -20,
            right: -20,
            child: Image.asset(
              widget.menuItem.image,
              width: MediaQuery.of(context).size.width * 0.45,
            ),
          ),
        ],
      ),
    );
  }
}
