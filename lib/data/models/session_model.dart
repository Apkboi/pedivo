import 'package:latlong2/latlong.dart';

import '../../domain/entities/verification_status.dart';
import '../../domain/entities/walking_session.dart';

class SessionModel extends WalkingSession {
  const SessionModel({
    required super.id,
    required super.title,
    required super.startTime,
    required super.duration,
    required super.distanceKm,
    required super.stepCount,
    required super.calories,
    required super.status,
    required super.routePoints,
  });

  static SessionModel seed({
    required String id,
    required String title,
    required DateTime startTime,
    required int minutes,
    required double distanceKm,
    required int stepCount,
    required double calories,
    required VerificationStatus status,
    required List<LatLng> points,
  }) {
    return SessionModel(
      id: id,
      title: title,
      startTime: startTime,
      duration: Duration(minutes: minutes),
      distanceKm: distanceKm,
      stepCount: stepCount,
      calories: calories,
      status: status,
      routePoints: points,
    );
  }
}
