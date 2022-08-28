import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/widgets/app_bar_leading.dart';
import 'package:flutter_vikings/core/widgets/delayed_fade_in_effect.dart';
import 'package:flutter_vikings/features/recipes/models/recipe.dart';
import 'package:flutter_vikings/features/recipes/views/widgets/recipe_image.dart';
import 'package:flutter_vikings/features/recipes/views/widgets/recipe_image_pattern_mouse.dart';
import 'package:flutter_vikings/features/recipes/views/widgets/recipe_page_image_bg.dart';

class RecipePageSidebar extends StatefulWidget {
  const RecipePageSidebar(
    this.recipe, {
    Key? key,
    this.imageRotationAngle = 0,
  }) : super(key: key);

  final Recipe recipe;
  final double imageRotationAngle;

  @override
  State<RecipePageSidebar> createState() => _RecipePageSidebarState();
}

class _RecipePageSidebarState extends State<RecipePageSidebar> {
  Offset offset = const Offset(0, 0);
  Alignment mouseRegionAlignment = Alignment.bottomRight;
  static const maxMovableDistance = 10;

  Alignment alignmentFromOffset(
      Offset mousePosition, double width, double height) {
    if (mousePosition.dx > width / 2) {
      return mousePosition.dy > height / 2
          ? Alignment.bottomRight
          : Alignment.topRight;
    } else {
      return mousePosition.dy > height / 2
          ? Alignment.bottomLeft
          : Alignment.topLeft;
    }
  }

  Offset offsetFromMousePosition(
    Offset mousePosition,
    double width,
    double height,
  ) {
    Alignment alignment = alignmentFromOffset(mousePosition, width, height);
    return Offset(
      maxMovableDistance * alignment.x * -1,
      maxMovableDistance * alignment.y * -1,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width / 2;
    double height = screenSize.height;

    return MouseRegion(
      hitTestBehavior: HitTestBehavior.opaque,
      onEnter: (PointerEnterEvent event) {
        setState(() {
          offset = offsetFromMousePosition(
            event.localPosition,
            width,
            height,
          );
        });
      },
      onHover: (PointerHoverEvent event) {
        setState(() {
          offset = offsetFromMousePosition(
            event.localPosition,
            width,
            height,
          );
        });
      },
      onExit: (PointerExitEvent event) {
        setState(() {
          offset = offsetFromMousePosition(
            event.localPosition,
            width,
            height,
          );
        });
      },
      child: Stack(
        children: [
          RecipePageImageBg(
            widget.recipe,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          if (widget.recipe.bgImageName.isNotEmpty)
            DelayedFadeInEffect(
              child: RecipeImagePatternMouse(
                widget.recipe,
                offset: offset,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
            ),
          IgnorePointer(
            ignoring: true,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: RecipeImage(
                  widget.recipe,
                  imageRotationAngle: widget.imageRotationAngle,
                  shadowOffset: offset * 0.5,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: AppBarLeading(
              text: 'Back to Recipes',
              popValue: widget.imageRotationAngle,
            ),
          ),
        ],
      ),
    );
  }
}
