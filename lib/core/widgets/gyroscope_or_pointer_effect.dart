import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vikings/features/recipes/providers/gyroscope_provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeOrPointerEffect extends StatefulWidget {
  const GyroscopeOrPointerEffect({
    Key? key,
    required this.child,
    this.maxMovableDistance = 10,
    this.offsetMultiplier = 1,
  }) : super(key: key);

  final Widget child;
  final double maxMovableDistance;
  final double offsetMultiplier;

  @override
  State<GyroscopeOrPointerEffect> createState() =>
      _GyroscopeOrPointerEffectState();
}

class _GyroscopeOrPointerEffectState extends State<GyroscopeOrPointerEffect> {
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
          y += gyroscopeEvent.y;
          x += gyroscopeEvent.x;
        }

        x = x.clamp(-widget.maxMovableDistance, widget.maxMovableDistance);
        y = y.clamp(-widget.maxMovableDistance, widget.maxMovableDistance);

        return AnimatedPositioned(
          top: x * widget.offsetMultiplier,
          bottom: x * widget.offsetMultiplier,
          left: -y * widget.offsetMultiplier,
          right: y * widget.offsetMultiplier,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: child!,
        );
      },
    );
  }
}
