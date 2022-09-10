import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_ui/core/widgets/adaptive_offset_effect.dart';
import 'package:recipes_ui/features/recipes/providers/gyroscope_provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeEffect extends StatefulWidget {
  const GyroscopeEffect({
    Key? key,
    required this.child,
    this.maxMovableDistance = 10,
    this.offsetMultiplier = 1,
    this.childBuilder,
  })  : assert(child != null && childBuilder == null),
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
  final OffsetEffectBuilder? childBuilder;

  @override
  State<GyroscopeEffect> createState() => _GyroscopeEffectState();
}

class _GyroscopeEffectState extends State<GyroscopeEffect> {
  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
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

  Widget _buildChild(BuildContext context, double x, double y, Widget? child) {
    if (widget.childBuilder != null) {
      return widget.childBuilder!.call(
        context,
        Offset(-x, -y) * widget.offsetMultiplier,
        child,
      );
    } else {
      return TweenAnimationBuilder(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: Offset(-x, -y) * widget.offsetMultiplier,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        builder: (context, Offset offset, child) => Transform.translate(
          offset: offset,
          child: child!,
        ),
        child: child,
      );
    }
  }
}
