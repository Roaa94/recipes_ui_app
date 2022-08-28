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
  State<RecipeImagePatternMobile> createState() => _RecipeImagePatternMobileState();
}

class _RecipeImagePatternMobileState extends State<RecipeImagePatternMobile> {
  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
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
          top: x.clamp(-10, 10),
          bottom: -(x.clamp(-10, 10)).toDouble(),
          left: y.clamp(-10, 10),
          right: -(y.clamp(-10, 10)).toDouble(),
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: child!,
        );
      },
    );
  }
}
