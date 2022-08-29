import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipes_ui/core/enums/screen_size.dart';
import 'package:recipes_ui/core/styles/app_colors.dart';
import 'package:recipes_ui/features/recipes/recipes_data.dart';
import 'package:recipes_ui/features/recipes/recipes_layout.dart';
import 'package:recipes_ui/features/recipes/views/widgets/recipe_list_item.dart';
import 'package:recipes_ui/features/recipes/views/widgets/recipe_list_item_wrapper.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  late final ValueNotifier<ScrollDirection> scrollDirectionNotifier;
  final ScrollController scrollController = ScrollController();

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
        title: const Text('Dessert Recipes'),
        leading: GestureDetector(
          onTap: () {
            scrollDirectionNotifier.value = ScrollDirection.forward;
            scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 4000),
              curve: Curves.ease,
            );
          },
          child: Container(
            width: 100,
            height: 100,
            color: AppColors.sugar,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              scrollDirectionNotifier.value = ScrollDirection.reverse;
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 4000),
                curve: Curves.ease,
              );
            },
            child: Container(
              width: 100,
              height: 100,
              color: AppColors.sugar,
            ),
          ),
        ],
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
          controller: scrollController,
          padding: EdgeInsets.only(
            left: ScreenSize.of(context).isLarge ? 5 : 3.5,
            right: ScreenSize.of(context).isLarge ? 5 : 3.5,
            top: 10,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: RecipesLayout.of(context).gridCrossAxisCount,
            childAspectRatio: RecipesLayout.of(context).gridChildAspectRatio,
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
