import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/enums/screen_size.dart';
import 'package:flutter_vikings/menu/models/food_menu_item.dart';
import 'package:flutter_vikings/menu/views/widgets/menu_list_item_text_wrapper.dart';

class MenuListItemText extends StatelessWidget {
  const MenuListItemText(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final FoodMenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return MenuListItemTextWrapper(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: ScreenSize.of(context).isLarge ? 40 : 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: ScreenSize.of(context).isLarge
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Text(
              menuItem.title,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: menuItem.textColor,
                  ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                menuItem.description,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: menuItem.textColor,
                    ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
