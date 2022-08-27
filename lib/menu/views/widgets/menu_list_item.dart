import 'package:flutter/material.dart';
import 'package:flutter_vikings/menu/models/menu_item.dart';

class MenuListItem extends StatelessWidget {
  const MenuListItem(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final FoodMenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: menuItem.bgColor,
        borderRadius: BorderRadius.circular(35),
      ),
      height: 200,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(menuItem.title),
                Text(menuItem.description),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
