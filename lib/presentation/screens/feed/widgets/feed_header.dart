import 'package:flutter/material.dart';

import '../../../common_widgets/app_text.dart';

class FeedHeader extends StatelessWidget {
  const FeedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xFF06D9D1),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: AppText(
              'V',
              size: 20,
              weight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(),
        _headerChip(icon: Icons.public, value: '0'),
        const SizedBox(width: 10),
        _headerChip(icon: Icons.local_fire_department, value: '0'),
        const SizedBox(width: 12),
        Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.notifications_none_rounded, size: 26),
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFFC4A5B),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _headerChip({required IconData icon, required String value}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: const [
        BoxShadow(
          color: Color(0x13000000),
          blurRadius: 10,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF6E7591)),
        const SizedBox(width: 6),
        AppText(value, size: 18, weight: FontWeight.w700),
      ],
    ),
  );
}
