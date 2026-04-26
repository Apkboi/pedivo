import '../models/session_model.dart';

abstract interface class SessionSource {
  List<SessionModel> load();
}
