import '../entities/walking_session.dart';
import '../repositories/session_repository.dart';

class GetSessions {
  const GetSessions(this._repository);

  final SessionRepository _repository;

  Future<List<WalkingSession>> call() => _repository.getSessions();
  Future<WalkingSession> byId(String id) => _repository.getSessionById(id);
}
