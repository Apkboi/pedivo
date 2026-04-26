import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class RoutePathOverlay extends StatelessWidget {
  const RoutePathOverlay({super.key, required this.points});

  final List<Offset> points;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _RoutePainter(points));
  }
}

class _RoutePainter extends CustomPainter {
  const _RoutePainter(this.points);

  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;
    final scaled = points
        .map(
          (p) => Offset(
            20 + p.dx * (size.width - 40),
            20 + p.dy * (size.height - 40),
          ),
        )
        .toList();

    final start = scaled.first;
    final end = scaled.last;
    final midX = (start.dx + end.dx) / 2;
    final baseMidY = (start.dy + end.dy) / 2;
    final bend = ((end.dx - start.dx).abs() * 0.2).clamp(12.0, 26.0);
    final control = Offset(
      midX,
      (baseMidY - bend).clamp(20.0, size.height - 20.0),
    );
    final route = Path()
      ..moveTo(start.dx, start.dy)
      ..quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);

    final routePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(route, routePaint);

    final markerPaint = Paint()..color = AppColors.deepPrimary;
    canvas.drawCircle(start, 6, markerPaint);
    canvas.drawCircle(end, 6, markerPaint);
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
