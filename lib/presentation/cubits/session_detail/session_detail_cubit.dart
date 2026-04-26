import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_sessions.dart';
import 'session_detail_state.dart';

class SessionDetailCubit extends Cubit<SessionDetailState> {
  SessionDetailCubit({required GetSessions getSessions})
    : _getSessions = getSessions,
      super(const SessionDetailInitial());

  final GetSessions _getSessions;

  /// Loads a session by id using repository status as source of truth.
  Future<void> loadSession(String id) async {
    emit(const SessionDetailLoading());
    try {
      final session = await _getSessions.byId(id);
      emit(
        SessionDetailLoaded(
          session: session,
          verificationResult: session.status,
        ),
      );
    } catch (error) {
      emit(SessionDetailError(error.toString()));
    }
  }
}
