import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedivo/presentation/common_widgets/app_text.dart';

import '../../../domain/usecases/get_sessions.dart';
import '../../../core/extensions/datetime_ext.dart';
import '../../cubits/session_detail/session_detail_cubit.dart';
import '../../cubits/session_detail/session_detail_state.dart';
import '../feed/widgets/status_badge.dart';
import 'widgets/route_map_widget.dart';
import 'widgets/stat_tile.dart';
import 'widgets/verification_panel.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SessionDetailCubit(getSessions: context.read<GetSessions>())
            ..loadSession(sessionId),
      child: Scaffold(
        appBar: AppBar(title: const AppText('Session Detail', size: 18)),
        body: BlocBuilder<SessionDetailCubit, SessionDetailState>(
          builder: (context, state) => switch (state) {
            SessionDetailInitial() || SessionDetailLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            SessionDetailError() => Center(child: Text(state.message)),
            SessionDetailLoaded() => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                RouteMapWidget(session: state.session),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${state.session.title}\n${state.session.startTime.sessionRelativeLabel}, ${state.session.startTime.sessionTimeLabel}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    StatusBadge(
                      status: state.verificationResult,
                      heroTag: 'status-${state.session.id}',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  childAspectRatio: 1.2,
                  children: [
                    StatTile(
                      value: '${state.session.duration.inMinutes} min',
                      label: 'Duration',
                      icon: Icons.timer_outlined,
                      iconColor: Colors.blue,
                    ),
                    StatTile(
                      value:
                          '${state.session.distanceKm.toStringAsFixed(1)} km',
                      label: 'Distance',
                      icon: Icons.location_on_outlined,
                      iconColor: Colors.purple,
                    ),
                    StatTile(
                      value: '${state.session.stepCount}',
                      label: 'Steps',
                      icon: Icons.directions_walk,
                      iconColor: Colors.teal,
                    ),
                    StatTile(
                      value:
                          '${state.session.averageSpeedKmh.toStringAsFixed(1)} km/h',
                      label: 'Avg speed',
                      icon: Icons.speed_outlined,
                      iconColor: Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                VerificationPanel(session: state.session),
              ],
            ),
          },
        ),
      ),
    );
  }
}
