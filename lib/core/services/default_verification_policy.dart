import '../../domain/entities/verification_status.dart';
import '../../domain/entities/walking_session.dart';
import '../../domain/services/verification_policy.dart';
import '../constants.dart';

class DefaultVerificationPolicy implements VerificationPolicy {
  const DefaultVerificationPolicy();

  @override
  VerificationStatus verify(WalkingSession session) {
    final distanceOk = session.distanceKm >= AppConstants.minDistanceKm;
    final durationOk =
        session.duration.inMinutes >= AppConstants.minDurationMin;
    final speed = session.averageSpeedKmh;
    final speedOk =
        speed >= AppConstants.minSpeedKmh && speed <= AppConstants.maxSpeedKmh;

    if (distanceOk && durationOk && speedOk) return VerificationStatus.verified;
    if (!distanceOk || !durationOk) return VerificationStatus.rejected;
    return VerificationStatus.pending;
  }
}
