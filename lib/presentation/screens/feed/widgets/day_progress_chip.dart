import 'package:flutter/material.dart';

import '../../../common_widgets/app_text.dart';
import '../../../theme/app_colors.dart';

class DayProgressChip extends StatelessWidget {
  const DayProgressChip({
    super.key,
    required this.dayLabel,
    required this.percentLabel,
    required this.isToday,
  });

  final String dayLabel;
  final String percentLabel;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isToday ? AppColors.primary : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isToday ? AppColors.primary : const Color(0xFFE7ECF4),
            ),
          ),
          child: AppText(
            percentLabel,
            size: 13,
            weight: FontWeight.w700,
            color: isToday ? Colors.white : AppColors.muted,
          ),
        ),
        const SizedBox(height: 8),
        AppText(
          dayLabel,
          size: 13,
          weight: FontWeight.w500,
          color: AppColors.muted,
        ),
      ],
    );
  }
}
