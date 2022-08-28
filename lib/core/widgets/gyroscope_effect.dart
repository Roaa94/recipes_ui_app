import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vikings/features/recipes/providers/gyroscope_provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeEffect extends StatefulWidget {
  const GyroscopeEffect({
    Key? key,
    required this.child,
    this.maxMovableDistance = 10,
    this.offsetMultiplier = 1,
  }) : super(key: key);

  final Widget child;
  final double maxMovableDistance;
  final double offsetMultiplier;

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
      return _buildChild(0, 0, widget.child);
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

          return _buildChild(x, y, widget.child);
        },
      );
    }
  }

  Widget _buildChild(double x, double y, Widget child) {
    return AnimatedPositioned(
      top: x * widget.offsetMultiplier,
      bottom: x * widget.offsetMultiplier,
      left: -y * widget.offsetMultiplier,
      right: y * widget.offsetMultiplier,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: child,
    );
  }
}
