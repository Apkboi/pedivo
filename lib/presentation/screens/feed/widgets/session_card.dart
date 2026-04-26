import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/extensions/datetime_ext.dart';
import '../../../common_widgets/app_text.dart';
import '../../../../domain/entities/walking_session.dart';
import 'status_badge.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({super.key, required this.session, required this.onTap});

  final WalkingSession session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFF08D8D0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/svg/ic_step.svg',
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              session.title,
                              size: 16,
                              weight: FontWeight.w700,
                            ),
                          ),
                          StatusBadge(
                            status: session.status,
                            heroTag: 'status-${session.id}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      AppText(
                        session.startTime.sessionDateTimeLabel,
                        size: 13,
                        color: const Color(0xFF6E7591),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  color: Colors.blueGrey,
                  size: 17,
                ),
                const SizedBox(width: 5),
                AppText(
                  '${session.duration.inMinutes} min',
                  size: 13,
                  color: const Color(0xFF6E7591),
                ),
                const SizedBox(width: 20),
                SvgPicture.asset(
                  'assets/images/svg/ic_step.svg',
                  width: 17,
                  height: 17,
                  colorFilter: const ColorFilter.mode(
                    Colors.blueGrey,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 5),
                AppText(
                  '${session.stepCount} steps',
                  size: 13,
                  color: const Color(0xFF6E7591),
                ),
                Spacer(),
                const SizedBox(width: 6),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFFB2B8CF),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
