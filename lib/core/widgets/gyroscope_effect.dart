import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_ui/features/recipes/providers/gyroscope_provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

typedef GyroscopeEffectBuilder = Widget Function(
  BuildContext context,
  Offset offset,
  Widget? child,
);

class GyroscopeEffect extends StatefulWidget {
  const GyroscopeEffect({
    Key? key,
    required this.child,
    this.maxMovableDistance = 10,
    this.offsetMultiplier = 1,
    this.childBuilder,
  })  : assert(child != null),
        super(key: key);

  const GyroscopeEffect.builder({
    Key? key,
    this.child,
    this.maxMovableDistance = 10,
    this.offsetMultiplier = 1,
    required this.childBuilder,
  })  : assert(childBuilder != null),
        super(key: key);

  /// Moving child widget
  final Widget? child;

  /// Maximum distance allowed for the child to move in
  final double maxMovableDistance;

  /// Value to multiply the movement offset to allow some widgets
  /// to move further than the other
  final double offsetMultiplier;

  /// A builder that provides necessary data to build a moving child
  /// with its child not rebuilding with the stream
  final GyroscopeEffectBuilder? childBuilder;

  @override
  State<GyroscopeEffect> createState() => _GyroscopeEffectState();
}

class _GyroscopeEffectState extends State<GyroscopeEffect> {
  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux) {
      return _buildChild(context, 0, 0, widget.child);
    } else {
      return Consumer(
        child: widget.child,
        builder: (context, ref, child) {
          final GyroscopeEvent? gyroscopeEvent =
              ref.watch(gyroscopeProvider).value;
          if (gyroscopeEvent != null) {
            x += gyroscopeEvent.y;
            y += gyroscopeEvent.x;
          }
          x = x.clamp(-widget.maxMovableDistance, widget.maxMovableDistance);
          y = y.clamp(-widget.maxMovableDistance, widget.maxMovableDistance);

          return _buildChild(context, x, y, child);
        },
      );
    }
  }

  Widget _buildChild(BuildContext context, double x, double y, Widget? child) {
    if (widget.childBuilder != null) {
      return widget.childBuilder!.call(
        context,
        Offset(-x, -y) * widget.offsetMultiplier,
        child,
      );
    } else {
      return AnimatedPositioned(
        top: y * widget.offsetMultiplier,
        bottom: y * widget.offsetMultiplier,
        left: -x * widget.offsetMultiplier,
        right: x * widget.offsetMultiplier,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: child!,
      );
    }
  }
}
