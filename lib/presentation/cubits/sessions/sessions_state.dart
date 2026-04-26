import '../../../../core/utils/dashboard_metrics.dart';
import '../../../../domain/entities/walking_session.dart';

sealed class SessionsState {
  const SessionsState();
}

class SessionsInitial extends SessionsState {
  const SessionsInitial();
}

class SessionsLoading extends SessionsState {
  const SessionsLoading();
}

class SessionsLoaded extends SessionsState {
  const SessionsLoaded({required this.sessions, required this.metrics});

  final List<WalkingSession> sessions;
  final DashboardMetrics metrics;
}

class SessionsEmpty extends SessionsState {
  const SessionsEmpty();
}

class SessionsError extends SessionsState {
  const SessionsError(this.message);
  final String message;
}
