import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedivo/core/services/default_verification_policy.dart';
import 'package:pedivo/domain/entities/verification_status.dart';
import 'package:pedivo/domain/entities/walking_session.dart';

void main() {
  const policy = DefaultVerificationPolicy();

  test('verified when all rules pass', () {
    final session = _buildSession(distanceKm: 2, durationMin: 30);
    expect(policy.verify(session), VerificationStatus.verified);
  });

  test('rejected when distance too short', () {
    final session = _buildSession(distanceKm: 0.2, durationMin: 30);
    expect(policy.verify(session), VerificationStatus.rejected);
  });
}

WalkingSession _buildSession({
  required double distanceKm,
  required int durationMin,
}) {
  return WalkingSession(
    id: 't1',
    title: 'Test',
    startTime: DateTime.now(),
    duration: Duration(minutes: durationMin),
    distanceKm: distanceKm,
    stepCount: 3200,
    calories: 200,
    status: VerificationStatus.pending,
    routePoints: const [
      LatLng(51.5, -0.12),
      LatLng(51.51, -0.121),
      LatLng(51.512, -0.122),
      LatLng(51.513, -0.123),
      LatLng(51.514, -0.124),
      LatLng(51.515, -0.125),
      LatLng(51.516, -0.126),
      LatLng(51.517, -0.127),
    ],
  );
}
