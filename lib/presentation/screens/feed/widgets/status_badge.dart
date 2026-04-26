import 'package:flutter/material.dart';

import '../../../../domain/entities/verification_status.dart';
import '../../../theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status, this.heroTag});

  final VerificationStatus status;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final badge = AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Container(
        key: ValueKey(status),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(
          color: _bg(status),
          border: Border.all(color: _fg(status), width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          _label(status),
          style: TextStyle(
            color: _fg(status),
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
    );
    if (heroTag == null) return badge;
    return Hero(tag: heroTag!, child: badge);
  }

  Color _bg(VerificationStatus value) => switch (value) {
    VerificationStatus.verified => const Color(0xFFECFDF3),
    VerificationStatus.pending => const Color(0xFFFFF8E7),
    VerificationStatus.rejected => const Color(0xFFFFEFF1),
  };

  Color _fg(VerificationStatus value) => switch (value) {
    VerificationStatus.verified => AppColors.success,
    VerificationStatus.pending => AppColors.warning,
    VerificationStatus.rejected => AppColors.danger,
  };

  String _label(VerificationStatus value) => switch (value) {
    VerificationStatus.verified => 'Verified',
    VerificationStatus.pending => 'Pending',
    VerificationStatus.rejected => 'Rejected',
  };
}
