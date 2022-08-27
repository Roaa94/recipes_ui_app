import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vikings/recipes/recipes_data.dart';
import 'package:flutter_vikings/recipes/recipes_layout.dart';
import 'package:flutter_vikings/recipes/views/widgets/recipe_list_item.dart';
import 'package:flutter_vikings/recipes/views/widgets/recipe_list_item_wrapper.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
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
            crossAxisCount: RecipesLayout.of(context).gridCrossAxisCount,
            childAspectRatio: RecipesLayout.of(context).gridChildAspectRatio,
            mainAxisSpacing: 25,
            crossAxisSpacing: 25,
          ),
          itemCount: RecipesData.dessertMenu.length,
          cacheExtent: 0,
          itemBuilder: (context, i) {
            return ValueListenableBuilder(
              valueListenable: scrollDirectionNotifier,
              child: RecipeListItem(RecipesData.dessertMenu[i]),
              builder: (context, ScrollDirection scrollDirection, child) {
                return RecipeListItemWrapper(
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
