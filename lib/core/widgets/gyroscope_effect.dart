import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vikings/features/recipes/providers/gyroscope_provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

typedef GyroscopeEffectBuilder = Widget Function(
    BuildContext context, Offset offset, Widget? child);

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

  final Widget? child;
  final double maxMovableDistance;
  final double offsetMultiplier;
  final GyroscopeEffectBuilder? childBuilder;

  @override
  State<GyroscopeEffect> createState() => _GyroscopeEffectState();
}

class _GyroscopeEffectState extends State<GyroscopeEffect> {
  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux) {
      return _buildChild(context, 0, 0, widget.child);
    } else {
      return Consumer(
        child: widget.child,
        builder: (context, ref, child) {
          final GyroscopeEvent? gyroscopeEvent =
              ref.watch(gyroscopeProvider).value;
          if (gyroscopeEvent != null) {
            y += gyroscopeEvent.y;
            x += gyroscopeEvent.x;
          }

          x = x.clamp(-widget.maxMovableDistance, widget.maxMovableDistance);
          y = y.clamp(-widget.maxMovableDistance, widget.maxMovableDistance);

          return _buildChild(context, x, y, child);
        },
      );
    }
  }

  Widget _buildChild(
    BuildContext context,
    double x,
    double y,
    Widget? child,
  ) {
    if (widget.childBuilder != null) {
      return widget.childBuilder!.call(
        context,
        Offset(-y, -x) * widget.offsetMultiplier,
        child,
      );
    } else {
      return AnimatedPositioned(
        top: x * widget.offsetMultiplier,
        bottom: x * widget.offsetMultiplier,
        left: -y * widget.offsetMultiplier,
        right: y * widget.offsetMultiplier,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: widget.child!,
      );
    }
  }
}
