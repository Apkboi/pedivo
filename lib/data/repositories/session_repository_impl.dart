import '../../domain/entities/walking_session.dart';
import '../../domain/repositories/session_repository.dart';
import '../sources/session_source.dart';

class SessionRepositoryImpl implements SessionRepository {
  SessionRepositoryImpl(this._source);

  final SessionSource _source;

  @override
  Future<List<WalkingSession>> getSessions() async => _source.load();

  @override
  Future<WalkingSession> getSessionById(String id) async {
    final sessions = _source.load();
    return sessions.firstWhere((session) => session.id == id);
  }
}
