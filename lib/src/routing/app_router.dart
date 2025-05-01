import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:campervan/src/features/home/homepage.dart';
import 'package:campervan/src/features/settings/presentation/settings_view.dart';
import 'package:campervan/src/routing/app_startup.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute { home, settings }

@riverpod
GoRouter goRouter(Ref ref) {
  ref.watch(appStartupProvider);
  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const HomePage());
        },
      ),
      GoRoute(
        path: '/settings',
        name: AppRoute.settings.name,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const SettingsView());
        },
      ),
    ],
  );
}

/// A page that fades in an out.
class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({required LocalKey key, required Widget child})
    : super(
        key: key,
        transitionsBuilder:
            (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                FadeTransition(opacity: animation.drive(_curveTween), child: child),
        child: child,
      );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
