import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

final gyroscopeProvider = StreamProvider<GyroscopeEvent>((_) {
  return SensorsPlatform.instance.gyroscopeEvents;
});
