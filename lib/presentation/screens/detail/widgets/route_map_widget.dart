import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' show LatLng;

import '../../../../domain/entities/walking_session.dart';
import 'route_path_overlay.dart';

class RouteMapWidget extends StatelessWidget {
  const RouteMapWidget({super.key, required this.session});

  final WalkingSession session;
  static const String _mapAssetPath = 'assets/images/detail_map.png';

  @override
  Widget build(BuildContext context) {
    final points = _normalize(session.routePoints);
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 210,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _mapAssetPath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFF8FBFF), Color(0xFFEFF4FA)],
                  ),
                ),
              ),
            ),

            RoutePathOverlay(points: points),
          ],
        ),
      ),
    );
  }

  List<Offset> _normalize(List<LatLng> source) {
    if (source.isEmpty) return const [];
    final minLat = source
        .map((e) => e.latitude)
        .reduce((a, b) => a < b ? a : b);
    final maxLat = source
        .map((e) => e.latitude)
        .reduce((a, b) => a > b ? a : b);
    final minLng = source
        .map((e) => e.longitude)
        .reduce((a, b) => a < b ? a : b);
    final maxLng = source
        .map((e) => e.longitude)
        .reduce((a, b) => a > b ? a : b);
    final latRange = (maxLat - minLat).abs() < 0.000001
        ? 1.0
        : (maxLat - minLat);
    final lngRange = (maxLng - minLng).abs() < 0.000001
        ? 1.0
        : (maxLng - minLng);

    return source.map((point) {
      final x = (point.longitude - minLng) / lngRange;
      final y = 1 - ((point.latitude - minLat) / latRange);
      return Offset(x, y);
    }).toList();
  }
}
