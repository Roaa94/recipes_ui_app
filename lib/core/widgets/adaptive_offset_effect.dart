import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipes_ui/core/widgets/gyroscope_effect.dart';
import 'package:recipes_ui/core/widgets/mouse_region_effect.dart';

typedef OffsetEffectBuilder = Widget Function(
  BuildContext context,
  Offset offset,
  Widget? child,
);

class AdaptiveOffsetEffect extends StatelessWidget {
  const AdaptiveOffsetEffect({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    this.offsetMultiplier = 1,
    this.childBuilder,
    this.maxMovableDistance = 10,
  })  : assert(child != null),
        super(key: key);

  const AdaptiveOffsetEffect.builder({
    Key? key,
    required this.width,
    required this.height,
    this.child,
    this.offsetMultiplier = 1,
    required this.childBuilder,
    this.maxMovableDistance = 10,
  })  : assert(childBuilder != null),
        super(key: key);

  final double width;
  final double height;

  /// Moving child widget
  final Widget? child;

  /// Maximum distance allowed for the child to move in
  final double maxMovableDistance;

  /// Value to multiply the movement offset to allow some widgets
  /// to move further than the other
  final double offsetMultiplier;

  /// A builder that provides necessary data to build a moving child
  /// with its child not rebuilding with the stream
  final OffsetEffectBuilder? childBuilder;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux) {
      return childBuilder != null
          ? MouseRegionEffect.builder(
              width: width,
              height: height,
              maxMovableDistance: maxMovableDistance,
              offsetMultiplier: offsetMultiplier,
              childBuilder: childBuilder,
              child: child,
            )
          : MouseRegionEffect(
              width: width,
              height: height,
              maxMovableDistance: maxMovableDistance,
              offsetMultiplier: offsetMultiplier,
              child: child,
            );
    } else {
      return childBuilder != null
          ? GyroscopeEffect.builder(
              maxMovableDistance: maxMovableDistance,
              offsetMultiplier: offsetMultiplier,
              childBuilder: childBuilder,
              child: child,
            )
          : GyroscopeEffect(
              maxMovableDistance: maxMovableDistance,
              offsetMultiplier: offsetMultiplier,
              child: child,
            );
    }
  }
}
