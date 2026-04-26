import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SessionSkeleton extends StatelessWidget {
  const SessionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: const Color(0xFFEFF3F8),
        highlightColor: Colors.white,
        child: Container(
          height: 94,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: 3,
    );
  }
}
