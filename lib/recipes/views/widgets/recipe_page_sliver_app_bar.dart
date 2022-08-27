import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
import 'package:flutter_vikings/core/widgets/app_bar_leading.dart';
import 'package:flutter_vikings/recipes/models/recipe.dart';

class FoodItemSliverAppBar extends StatefulWidget {
  const FoodItemSliverAppBar({
    Key? key,
    this.scrollController,
    required this.menuItem,
    this.expandedHeight = 340,
    this.collapsedHeight = 200,
  }) : super(key: key);

  final ScrollController? scrollController;
  final Recipe menuItem;
  final double? expandedHeight;
  final double? collapsedHeight;

  @override
  State createState() => _FoodItemSliverAppBarState();
}

class _FoodItemSliverAppBarState extends State<FoodItemSliverAppBar> {
  void scrollListener() {
    if (widget.expandedHeight != null &&
        widget.scrollController != null &&
        widget.scrollController!.position.pixels > widget.expandedHeight!) {
      // setState(() {
      // });
    } else {
      // setState(() {
      // });
    }
  }

  @override
  void initState() {
    if (widget.scrollController != null) {
      widget.scrollController!.addListener(scrollListener);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.scrollController != null) {
      widget.scrollController!.removeListener(scrollListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      collapsedHeight: widget.collapsedHeight,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: AppColors.getBrightness(widget.menuItem.bgColor),
      ),
      leading: AppBarLeading(
        bgColor: AppColors.textColorFromBackground(widget.menuItem.bgColor),
      ),
      expandedHeight: widget.expandedHeight == null
          ? null
          : widget.expandedHeight! + MediaQuery.of(context).padding.top,
      flexibleSpace: Stack(
        children: [
          Hero(
            tag: '__recipe_${widget.menuItem.id}_image_bg__',
            child: Container(
              decoration: BoxDecoration(
                color: widget.menuItem.bgColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.orangeDark.withOpacity(
                      AppColors.getBrightness(widget.menuItem.bgColor) ==
                              Brightness.dark
                          ? 0.5
                          : 0.2,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              alignment: Alignment.center,
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Hero(
                  tag: '__recipe_${widget.menuItem.id}_image__',
                  child: Image.asset(
                    widget.menuItem.image,
                    width: MediaQuery.of(context).size.width * 0.75,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
