import '../../domain/entities/walking_session.dart';
import '../constants.dart';

class DashboardMetrics {
  const DashboardMetrics({
    required this.todaySteps,
    required this.todayKm,
    required this.todayCalories,
    required this.progress,
    required this.weekdayProgress,
  });

  final int todaySteps;
  final double todayKm;
  final double todayCalories;
  final double progress;
  final List<WeekdayProgress> weekdayProgress;
}

class WeekdayProgress {
  const WeekdayProgress({
    required this.label,
    required this.percentLabel,
    required this.isToday,
  });

  final String label;
  final String percentLabel;
  final bool isToday;
}

DashboardMetrics buildDashboardMetrics(List<WalkingSession> sessions) {
  final today = DateTime.now();
  final todaySessions = sessions.where(
    (session) =>
        session.startTime.year == today.year &&
        session.startTime.month == today.month &&
        session.startTime.day == today.day,
  );

  final todaySteps = todaySessions.fold<int>(0, (sum, s) => sum + s.stepCount);
  final todayKm = todaySessions.fold<double>(0, (sum, s) => sum + s.distanceKm);
  final todayCalories = todaySessions.fold<double>(
    0,
    (sum, s) => sum + s.calories,
  );
  final progress = (todaySteps / AppConstants.goalSteps).clamp(0, 1).toDouble();

  const labels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Today'];
  final weekdayProgress = labels.asMap().entries.map((entry) {
    final isToday = entry.key == labels.length - 1;
    final value = isToday ? progress : 0.0;
    return WeekdayProgress(
      label: entry.value,
      percentLabel: '${(value * 100).toStringAsFixed(0)}%',
      isToday: isToday,
    );
  }).toList();

  return DashboardMetrics(
    todaySteps: todaySteps,
    todayKm: todayKm,
    todayCalories: todayCalories,
    progress: progress,
    weekdayProgress: weekdayProgress,
  );
}
