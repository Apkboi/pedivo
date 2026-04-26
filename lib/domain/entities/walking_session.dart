import 'package:latlong2/latlong.dart';

import 'verification_status.dart';

class WalkingSession {
  const WalkingSession({
    required this.id,
    required this.title,
    required this.startTime,
    required this.duration,
    required this.distanceKm,
    required this.stepCount,
    required this.calories,
    required this.status,
    required this.routePoints,
  });

  final String id;
  final String title;
  final DateTime startTime;
  final Duration duration;
  final double distanceKm;
  final int stepCount;
  final double calories;
  final VerificationStatus status;
  final List<LatLng> routePoints;

  double get averageSpeedKmh =>
      duration.inSeconds == 0 ? 0 : distanceKm / (duration.inSeconds / 3600);
}
