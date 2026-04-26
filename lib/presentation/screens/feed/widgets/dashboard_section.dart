import 'package:flutter/material.dart';

import '../../../../core/utils/dashboard_metrics.dart';
import '../../../common_widgets/app_text.dart';
import '../../../theme/app_colors.dart';
import 'dashboard_metric_tile.dart';
import 'day_progress_chip.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({super.key, required this.metrics});

  final DashboardMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFEFF2F7)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                width: 220,
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: metrics.progress,
                        strokeWidth: 11,
                        backgroundColor: const Color(0xFFF2F5FA),
                        color: AppColors.primary,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          '${metrics.todaySteps}',
                          size: 34,
                          weight: FontWeight.w700,
                        ),
                        const AppText(
                          'steps today',
                          size: 14,
                          weight: FontWeight.w500,
                          color: AppColors.muted,
                        ),
                        const SizedBox(height: 8),
                        AppText(
                          '${(metrics.progress * 100).toStringAsFixed(1)}%',
                          color: AppColors.primary,
                          size: 26,
                          weight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const AppText(
                'Goal: 20,000 steps',
                size: 15,
                weight: FontWeight.w500,
                color: AppColors.muted,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: metrics.weekdayProgress
              .map(
                (entry) => DayProgressChip(
                  dayLabel: entry.label,
                  percentLabel: entry.percentLabel,
                  isToday: entry.isToday,
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DashboardMetricTile(
                title: '${metrics.todayCalories.toStringAsFixed(0)} Kcal',
                subtitle: 'Calories burned',
                icon: Icons.local_fire_department,
                colors: const [Color(0xFF00E5D9), Color(0xFF00C8CD)],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DashboardMetricTile(
                title: '${metrics.todayKm.toStringAsFixed(2)} km',
                subtitle: 'Distance covered',
                icon: Icons.straighten,
                colors: const [Color(0xFF00D66B), Color(0xFF00C57A)],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
