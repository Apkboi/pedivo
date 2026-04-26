import '../entities/verification_status.dart';
import '../entities/walking_session.dart';

abstract interface class VerificationPolicy {
  VerificationStatus verify(WalkingSession session);
}
