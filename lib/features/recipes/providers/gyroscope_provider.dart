import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

final gyroscopeProvider = StreamProvider<GyroscopeEvent>((_) {
  if (defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux) {
    return const Stream.empty();
  } else {
    return SensorsPlatform.instance.gyroscopeEvents;
  }
});
