import 'dart:math';

import 'package:latlong2/latlong.dart';

List<LatLng> buildSeededRoutePoints({
  required String sessionId,
  required int minutes,
  required int steps,
  int pointCount = 12,
}) {
  final seed = sessionId.codeUnits.fold<int>(0, (sum, code) => sum + code);
  final random = Random(seed);

  final baseLat = 51.5072 + random.nextDouble() * 0.02 - 0.01;
  final baseLng = -0.1276 + random.nextDouble() * 0.02 - 0.01;
  final angleStart = random.nextDouble() * pi * 2;
  final spread = 0.001 + (minutes / 12000) + (steps / 3000000);
  final phase = random.nextDouble() * pi;

  return List.generate(pointCount, (index) {
    final t = index / (pointCount - 1);
    final angle = angleStart + t * (pi * (1.1 + random.nextDouble() * 1.2));
    final wave = sin((t * 4 * pi) + phase) * (spread * 0.35);
    final radius = spread * (0.8 + t * 0.8);
    final lat = baseLat + sin(angle) * radius + wave * 0.4;
    final lng = baseLng + cos(angle) * radius + wave * 0.3;
    return LatLng(lat, lng);
  });
}
