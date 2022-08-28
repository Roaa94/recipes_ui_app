import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/enums/screen_size.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';
import 'package:flutter_vikings/features/recipes/models/recipe.dart';

class RecipeImagePatternMouse extends StatefulWidget {
  const RecipeImagePatternMouse(
    this.recipe, {
    Key? key,
    required this.borderRadius,
    this.width,
    this.height,
  }) : super(key: key);

  final Recipe recipe;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  @override
  State<RecipeImagePatternMouse> createState() =>
      _RecipeImagePatternMouseState();
}

class _RecipeImagePatternMouseState extends State<RecipeImagePatternMouse> {
  Offset offset = const Offset(0, 0);
  Alignment mouseRegionAlignment = Alignment.bottomRight;
  static const maxMovableDistance = 10;

  Alignment alignmentFromOffset(Offset mousePosition) {
    if (widget.width != null && widget.height != null) {
      if (mousePosition.dx > widget.width! / 2) {
        return mousePosition.dy > widget.height! / 2
            ? Alignment.bottomRight
            : Alignment.topRight;
      } else {
        return mousePosition.dy > widget.height! / 2
            ? Alignment.bottomLeft
            : Alignment.topLeft;
      }
    } else {
      return Alignment.bottomRight;
    }
  }

  Offset offsetFromMousePosition(Offset mousePosition) {
    Alignment alignment = alignmentFromOffset(mousePosition);
    return Offset(
      maxMovableDistance * alignment.x * -1,
      maxMovableDistance * alignment.y * -1,
    );
  }

  @override
  Widget build(BuildContext context) {
    String bgImage = ScreenSize.of(context).isLarge
        ? widget.recipe.bgImageLg
        : widget.recipe.bgImage;
    AlignmentGeometry alignment = ScreenSize.of(context).isLarge
        ? Alignment.center
        : Alignment.bottomCenter;

    return MouseRegion(
      hitTestBehavior: HitTestBehavior.opaque,
      onEnter: (PointerEnterEvent event) {
        setState(() {
          offset = offsetFromMousePosition(event.localPosition);
        });
      },
      onHover: (PointerHoverEvent event) {
        setState(() {
          offset = offsetFromMousePosition(event.localPosition);
        });
      },
      onExit: (PointerExitEvent event) {
        setState(() {
          offset = offsetFromMousePosition(event.localPosition);
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TweenAnimationBuilder(
            tween: Tween<Offset>(begin: Offset.zero, end: offset * 2),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            builder: (context, Offset offset, child) => Transform.translate(
              offset: offset,
              child: child,
            ),
            child: Align(
              alignment: alignment,
              child: ClipRRect(
                borderRadius: widget.borderRadius,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
                  child: Image.asset(
                    bgImage,
                    color: AppColors.orangeDark.withOpacity(0.5),
                    alignment: alignment,
                  ),
                ),
              ),
            ),
          ),
          TweenAnimationBuilder(
            tween: Tween<Offset>(begin: Offset.zero, end: offset),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            builder: (context, Offset offset, child) => Transform.translate(
              offset: offset,
              child: child,
            ),
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bgImage),
                    alignment: alignment,
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
