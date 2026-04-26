import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/dashboard_metrics.dart';
import '../../../../domain/usecases/get_sessions.dart';
import 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  SessionsCubit({required GetSessions getSessions})
    : _getSessions = getSessions,
      super(const SessionsInitial());

  final GetSessions _getSessions;

  /// Loads all walking sessions for the dashboard.
  Future<void> loadSessions() async {
    emit(const SessionsLoading());
    try {
      final sessions = await _getSessions();
      if (sessions.isEmpty) {
        emit(const SessionsEmpty());
        return;
      }
      final sortedSessions = List.of(sessions)
        ..sort((a, b) => b.startTime.compareTo(a.startTime));
      emit(
        SessionsLoaded(
          sessions: sortedSessions,
          metrics: buildDashboardMetrics(sortedSessions),
        ),
      );
    } catch (error) {
      emit(SessionsError(error.toString()));
    }
  }

  /// Reloads sessions for pull-to-refresh interactions.
  Future<void> refresh() => loadSessions();
}
