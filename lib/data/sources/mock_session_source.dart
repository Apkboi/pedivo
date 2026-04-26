import '../../domain/entities/verification_status.dart';
import '../../domain/services/verification_policy.dart';
import '../models/session_model.dart';
import 'seeded_route_builder.dart';
import 'session_source.dart';

class MockSessionSource implements SessionSource {
  const MockSessionSource(this._verificationPolicy);

  final VerificationPolicy _verificationPolicy;

  @override
  List<SessionModel> load() {
    final now = DateTime.now();
    final seeded = <SessionModel>[
      _session(
        '1',
        'Morning Walk',
        now.subtract(const Duration(hours: 15)),
        32,
        2.4,
        3200,
        210,
      ),
      _session(
        '2',
        'Evening Jog',
        now.subtract(const Duration(days: 1, hours: 6)),
        45,
        6.8,
        6800,
        425,
      ),
      _session(
        '3',
        'Lunch Break Walk',
        now.subtract(const Duration(days: 1, hours: 2)),
        15,
        1.5,
        1500,
        120,
      ),
      _session(
        '4',
        'Riverside Walk',
        now.subtract(const Duration(days: 2)),
        52,
        4.9,
        5800,
        340,
      ),
      _session(
        '5',
        'Office Commute',
        now.subtract(const Duration(days: 2, hours: 4)),
        27,
        1.9,
        2600,
        180,
      ),
      _session(
        '6',
        'City Steps',
        now.subtract(const Duration(days: 3)),
        62,
        5.4,
        7100,
        460,
      ),
      _session(
        '7',
        'Park Walk',
        now.subtract(const Duration(days: 3, hours: 6)),
        18,
        0.4,
        950,
        65,
      ),
      _session(
        '8',
        'Night Walk',
        now.subtract(const Duration(days: 4)),
        40,
        3.2,
        3900,
        240,
      ),
      _session(
        '9',
        'Campus Walk',
        now.subtract(const Duration(days: 4, hours: 7)),
        9,
        0.7,
        780,
        52,
      ),
      _session(
        '10',
        'Neighborhood',
        now.subtract(const Duration(days: 5)),
        76,
        5.8,
        7900,
        505,
      ),
      _session(
        '11',
        'Quick Break',
        now.subtract(const Duration(days: 6)),
        4,
        0.2,
        340,
        22,
      ),
      _session(
        '12',
        'Sunset Walk',
        now.subtract(const Duration(days: 6, hours: 5)),
        28,
        2.0,
        2800,
        175,
      ),
      _session(
        '13',
        'Fresh Air',
        now.subtract(const Duration(minutes: 4)),
        6,
        0.3,
        390,
        40,
      ),
      _session(
        '14',
        'Late Evening',
        now.subtract(const Duration(minutes: 8)),
        4,
        0.2,
        310,
        38,
      ),
      _session(
        '15',
        'Warmup Walk',
        now.subtract(const Duration(minutes: 10)),
        6,
        0.5,
        540,
        35,
      ),
    ];
    return seeded;
  }

  SessionModel _session(
    String id,
    String title,
    DateTime startTime,
    int minutes,
    double distanceKm,
    int steps,
    double calories,
  ) {
    final points = buildSeededRoutePoints(
      sessionId: id,
      minutes: minutes,
      steps: steps,
    );
    final candidate = SessionModel.seed(
      id: id,
      title: title,
      startTime: startTime,
      minutes: minutes,
      distanceKm: distanceKm,
      stepCount: steps,
      calories: calories,
      status: VerificationStatus.pending,
      points: points,
    );
    return SessionModel(
      id: candidate.id,
      title: candidate.title,
      startTime: candidate.startTime,
      duration: candidate.duration,
      distanceKm: candidate.distanceKm,
      stepCount: candidate.stepCount,
      calories: candidate.calories,
      status: _verificationPolicy.verify(candidate),
      routePoints: candidate.routePoints,
    );
  }
}
