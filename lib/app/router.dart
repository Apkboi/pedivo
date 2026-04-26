import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import '../presentation/screens/detail/detail_screen.dart';
import '../presentation/screens/feed/feed_screen.dart';

GoRouter buildRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.activityPath,
        name: AppRoutes.activityName,
        builder: (_, __) => const ActivityScreen(),
        routes: [
          GoRoute(
            path: AppRoutes.detailPath,
            name: AppRoutes.detailName,
            pageBuilder: (_, state) {
              final id = state.pathParameters[AppRoutes.sessionIdParam]!;
              return CustomTransitionPage<void>(
                child: DetailScreen(sessionId: id),
                transitionDuration: const Duration(milliseconds: 380),
                transitionsBuilder: (_, animation, __, child) {
                  final curved = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  );
                  final slide = Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(curved);
                  return FadeTransition(
                    opacity: curved,
                    child: SlideTransition(position: slide, child: child),
                  );
                },
              );
            },
          ),
        ],
      ),
    ],
  );
}
