import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../domain/entities/verification_criterion.dart';
import '../../../../domain/entities/walking_session.dart';
import '../../../theme/app_colors.dart';

class VerificationPanel extends StatelessWidget {
  const VerificationPanel({super.key, required this.session});

  final WalkingSession session;

  @override
  Widget build(BuildContext context) {
    final checks = [
      VerificationCriterion(
        'Distance > ${AppConstants.minDistanceKm} km',
        _criterionValue(
          '${session.distanceKm.toStringAsFixed(1)} km',
          session.distanceKm >= AppConstants.minDistanceKm,
        ),
        session.distanceKm >= AppConstants.minDistanceKm,
      ),
      VerificationCriterion(
        'Duration > ${AppConstants.minDurationMin} mins',
        _criterionValue(
          '${session.duration.inMinutes} mins',
          session.duration.inMinutes >= AppConstants.minDurationMin,
        ),
        session.duration.inMinutes >= AppConstants.minDurationMin,
      ),
      VerificationCriterion(
        'Speed ${AppConstants.minSpeedKmh}-${AppConstants.maxSpeedKmh} km/h',
        _criterionValue(
          '${session.averageSpeedKmh.toStringAsFixed(1)} km/h',
          session.averageSpeedKmh >= AppConstants.minSpeedKmh &&
              session.averageSpeedKmh <= AppConstants.maxSpeedKmh,
        ),
        session.averageSpeedKmh >= AppConstants.minSpeedKmh &&
            session.averageSpeedKmh <= AppConstants.maxSpeedKmh,
      ),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verification Criteria',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          ...checks.map(
            (item) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    item.passed ? Icons.check_circle : Icons.cancel,
                    color: item.passed ? AppColors.success : AppColors.danger,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    item.value,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _criterionValue(String value, bool passed) =>
      passed ? '$value achieved' : '$value not met';
}
