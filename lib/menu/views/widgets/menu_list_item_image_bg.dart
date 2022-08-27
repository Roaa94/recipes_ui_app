import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vikings/menu/views/providers/gyroscope_provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MenuListItemImageBg extends ConsumerWidget {
  MenuListItemImageBg({
    Key? key,
    required this.imageSize,
    required this.color,
  }) : super(key: key);

  final double imageSize;
  final Color color;

    double initX = 0.0;
    double initY = 0.0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ref.watch(gyroscopeProvider).when(
          data: (GyroscopeEvent gyroscopeEvent) {
            if (gyroscopeEvent.y.abs() > 0.0) {
              initX += gyroscopeEvent.y;
            }
            if (gyroscopeEvent.x.abs() > 0.0) {
              initY += gyroscopeEvent.x;
            }

            return Positioned(
              right: -20 + initX,
              bottom: -20 + initY,
              child: Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
            );
          },
          error: (_, __) => Container(),
          loading: () => Container(),
        );
  }
}
