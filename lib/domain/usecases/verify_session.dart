import '../entities/verification_status.dart';
import '../entities/walking_session.dart';
import '../services/verification_policy.dart';

class VerifySession {
  const VerifySession(this._policy);

  final VerificationPolicy _policy;

  VerificationStatus call(WalkingSession session) => _policy.verify(session);
}
