import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_routes.dart';
import '../../common_widgets/app_text.dart';
import '../../cubits/sessions/sessions_cubit.dart';
import '../../cubits/sessions/sessions_state.dart';
import 'widgets/dashboard_section.dart';
import 'widgets/feed_header.dart';
import 'widgets/session_card.dart';
import 'widgets/session_skeleton.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SessionsCubit, SessionsState>(
          builder: (context, state) => switch (state) {
            SessionsInitial() || SessionsLoading() => const SessionSkeleton(),
            SessionsEmpty() => const Center(
              child: AppText('No sessions yet', size: 16),
            ),
            SessionsError() => Center(
              child: AppText(state.message, size: 14, color: Color(0xFF6E7591)),
            ),
            SessionsLoaded() => RefreshIndicator(
              onRefresh: () => context.read<SessionsCubit>().refresh(),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const FeedHeader(),
                  const SizedBox(height: 16),
                  DashboardSection(metrics: state.metrics),
                  const SizedBox(height: 24),
                  const AppText(
                    'Recent Sessions',
                    size: 20,
                    weight: FontWeight.w700,
                  ),
                  const SizedBox(height: 12),
                  ...state.sessions
                      .take(6)
                      .map(
                        (session) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SessionCard(
                            session: session,
                            onTap: () => context.pushNamed(
                              AppRoutes.detailName,
                              pathParameters: {
                                AppRoutes.sessionIdParam: session.id,
                              },
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          },
        ),
      ),
    );
  }
}
