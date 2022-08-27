import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
import 'package:flutter_vikings/menu/models/food_menu_item.dart';
import 'package:flutter_vikings/menu/views/widgets/menu_list_item_image.dart';

class MenuListItem extends StatelessWidget {
  const MenuListItem(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final FoodMenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 170,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
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
            ),
          ),
          Positioned.fill(
            child: MenuListItemImage(menuItem),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
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
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
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
              Expanded(flex: 2, child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
