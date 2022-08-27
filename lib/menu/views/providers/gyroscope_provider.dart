import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

final xInitial = StateProvider<double>((_) => 0);
final yInitial = StateProvider<double>((_) => 0);

final gyroscopeProvider = StreamProvider<GyroscopeEvent>((_) {
  return SensorsPlatform.instance.gyroscopeEvents;
});

final xGyroscopeOffset = Provider<double>((ref) {
  final gyroscopeEvent = ref.watch(gyroscopeProvider).value;
  if (gyroscopeEvent != null) {
    return gyroscopeEvent.x.abs() > 0 ? gyroscopeEvent.x : 0;
  } else {
    return 0;
  }
});

final yGyroscopeOffset = Provider((ref) {
  final gyroscopeEvent = ref.watch(gyroscopeProvider).value;
  if (gyroscopeEvent != null) {
    return gyroscopeEvent.y.abs() > 0 ? gyroscopeEvent.y : 0;
  } else {
    return 0;
  }
});
