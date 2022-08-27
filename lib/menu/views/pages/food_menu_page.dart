import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vikings/menu/food_menu_data.dart';
import 'package:flutter_vikings/menu/food_menu_layout.dart';
import 'package:flutter_vikings/menu/views/widgets/menu_list_item.dart';
import 'package:flutter_vikings/menu/views/widgets/menu_list_item_wrapper.dart';

class FoodMenuPage extends StatefulWidget {
  const FoodMenuPage({Key? key}) : super(key: key);

  @override
  State<FoodMenuPage> createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {
  late final ValueNotifier<ScrollDirection> scrollDirectionNotifier;

  @override
  void initState() {
    scrollDirectionNotifier =
        ValueNotifier<ScrollDirection>(ScrollDirection.forward);
    super.initState();
  }

  @override
  void dispose() {
    scrollDirectionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desserts'),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (UserScrollNotification notification) {
          if (notification.direction == ScrollDirection.forward ||
              notification.direction == ScrollDirection.reverse) {
            scrollDirectionNotifier.value = notification.direction;
          }
          return true;
        },
        child: GridView.builder(
          padding: EdgeInsets.only(
            left: 17,
            right: 17,
            top: 10,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: FoodMenuLayout.of(context).gridCrossAxisCount,
            childAspectRatio: FoodMenuLayout.of(context).gridChildAspectRatio,
            mainAxisSpacing: 25,
            crossAxisSpacing: 25,
          ),
          itemCount: FoodMenuData.dessertMenu.length,
          cacheExtent: 0,
          itemBuilder: (context, i) {
            return ValueListenableBuilder(
              valueListenable: scrollDirectionNotifier,
              child: MenuListItem(FoodMenuData.dessertMenu[i]),
              builder: (context, ScrollDirection scrollDirection, child) {
                return MenuListItemWrapper(
                  scrollDirection: scrollDirection,
                  child: child!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
