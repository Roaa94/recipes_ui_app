import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/enums/screen_size.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
import 'package:flutter_vikings/menu/models/food_menu_item.dart';
import 'package:flutter_vikings/menu/views/pages/food_menu_item_page.dart';
import 'package:flutter_vikings/menu/views/widgets/menu_list_item_image.dart';

class MenuListItem extends StatelessWidget {
  const MenuListItem(
    this.menuItem, {
    Key? key,
  }) : super(key: key);

  final FoodMenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return FoodMenuItemPage(menuItem);
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: 170,
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: '__food_item_${menuItem.id}_image_bg__',
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    color: menuItem.bgColor,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.red.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  // child: MenuListItemImage(menuItem),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.bottomRight,
                child: MenuListItemImage(menuItem),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
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
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: menuItem.textColor,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          child: Text(
                            menuItem.description,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: menuItem.textColor,
                                    ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
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
      ),
    );
  }
}
