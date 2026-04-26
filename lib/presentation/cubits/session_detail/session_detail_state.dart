import '../../../../domain/entities/verification_status.dart';
import '../../../../domain/entities/walking_session.dart';

sealed class SessionDetailState {
  const SessionDetailState();
}

class SessionDetailInitial extends SessionDetailState {
  const SessionDetailInitial();
}

class SessionDetailLoading extends SessionDetailState {
  const SessionDetailLoading();
}

class SessionDetailLoaded extends SessionDetailState {
  const SessionDetailLoaded({
    required this.session,
    required this.verificationResult,
  });

  final WalkingSession session;
  final VerificationStatus verificationResult;
}

class SessionDetailError extends SessionDetailState {
  const SessionDetailError(this.message);
  final String message;
}
