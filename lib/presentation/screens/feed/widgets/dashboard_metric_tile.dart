import 'package:flutter/material.dart';

import '../../../common_widgets/app_text.dart';

class DashboardMetricTile extends StatelessWidget {
  const DashboardMetricTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(colors: colors),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2200CFC7),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 12),
          AppText(
            title,
            color: Colors.white,
            size: 18,
            weight: FontWeight.w700,
          ),
          AppText(
            subtitle,
            color: const Color(0xCCFFFFFF),
            size: 14,
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
