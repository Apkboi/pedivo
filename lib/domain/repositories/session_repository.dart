import '../entities/walking_session.dart';

abstract interface class SessionRepository {
  Future<List<WalkingSession>> getSessions();
  Future<WalkingSession> getSessionById(String id);
}
