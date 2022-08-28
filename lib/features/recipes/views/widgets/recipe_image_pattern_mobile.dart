import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vikings/features/recipes/models/recipe.dart';
import 'package:flutter_vikings/features/recipes/providers/gyroscope_provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

class RecipeImagePatternMobile extends StatefulWidget {
  const RecipeImagePatternMobile(
    this.recipe, {
    Key? key,
    required this.borderRadius,
  }) : super(key: key);

  final Recipe recipe;
  final BorderRadius borderRadius;

  @override
  State<RecipeImagePatternMobile> createState() =>
      _RecipeImagePatternMobileState();
}

class _RecipeImagePatternMobileState extends State<RecipeImagePatternMobile> {
  double x = 0;
  double y = 0;
  static const double maxMovableDistance = 10;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer(
          child: ClipRRect(
            borderRadius: widget.borderRadius,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
              child: Image.asset(
                widget.recipe.bgImage,
                color: Colors.black.withOpacity(0.3),
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          builder: (context, ref, child) {
            final GyroscopeEvent? gyroscopeEvent =
                ref.watch(gyroscopeProvider).value;
            if (gyroscopeEvent != null) {
              y += gyroscopeEvent.y;
              x += gyroscopeEvent.x;
            }

            return AnimatedPositioned(
              top: x.clamp(-maxMovableDistance, maxMovableDistance) * 1.5,
              bottom: -(x.clamp(-maxMovableDistance, maxMovableDistance))
                      .toDouble() *
                  1.5,
              left: y.clamp(-maxMovableDistance, maxMovableDistance) * 1.5,
              right: -(y.clamp(-maxMovableDistance, maxMovableDistance))
                      .toDouble() *
                  1.5,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              child: child!,
            );
          },
        ),
        Consumer(
          child: ClipRRect(
            borderRadius: widget.borderRadius,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.recipe.bgImage),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          builder: (context, ref, child) {
            final GyroscopeEvent? gyroscopeEvent =
                ref.watch(gyroscopeProvider).value;
            if (gyroscopeEvent != null) {
              y += gyroscopeEvent.y;
              x += gyroscopeEvent.x;
            }

            return AnimatedPositioned(
              top: x.clamp(-maxMovableDistance, maxMovableDistance),
              bottom: -(x.clamp(-maxMovableDistance, maxMovableDistance))
                  .toDouble(),
              left: y.clamp(-maxMovableDistance, maxMovableDistance),
              right: -(y.clamp(-maxMovableDistance, maxMovableDistance))
                  .toDouble(),
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              child: child!,
            );
          },
        ),
      ],
    );
  }
}
