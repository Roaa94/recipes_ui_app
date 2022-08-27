import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
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
        boxShadow: [
          BoxShadow(
            color: AppColors.red.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      height: 170,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        menuItem.title,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: menuItem.textColor,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    menuItem.description,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: menuItem.textColor,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Image.asset(menuItem.image),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
