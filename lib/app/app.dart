import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/services/default_verification_policy.dart';
import '../data/repositories/session_repository_impl.dart';
import '../data/sources/mock_session_source.dart';
import '../data/sources/session_source.dart';
import '../domain/repositories/session_repository.dart';
import '../domain/services/verification_policy.dart';
import '../domain/usecases/get_sessions.dart';
import '../domain/usecases/verify_session.dart';
import '../presentation/cubits/sessions/sessions_cubit.dart';
import '../presentation/theme/app_theme.dart';
import 'router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<VerificationPolicy>(
          create: (_) => const DefaultVerificationPolicy(),
        ),
        RepositoryProvider<SessionSource>(
          create: (context) =>
              MockSessionSource(context.read<VerificationPolicy>()),
        ),
        RepositoryProvider<SessionRepository>(
          create: (context) =>
              SessionRepositoryImpl(context.read<SessionSource>()),
        ),
        RepositoryProvider<GetSessions>(
          create: (context) => GetSessions(context.read<SessionRepository>()),
        ),
        RepositoryProvider<VerifySession>(
          create: (context) =>
              VerifySession(context.read<VerificationPolicy>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SessionsCubit(getSessions: context.read<GetSessions>())
                  ..loadSessions(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Pedivo',
          theme: AppTheme.light,
          routerConfig: _router,
        ),
      ),
    );
  }
}
