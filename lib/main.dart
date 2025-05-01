import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campervan/src/constants/theme_provider.dart';
import 'package:campervan/src/localisation/string_hardcoded.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:campervan/src/routing/app_router.dart';
import 'package:campervan/src/routing/app_startup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();
  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  registerErrorHandlers();
  // * Entry point of the app
  runApp(const ProviderScope(child: RootAppWidget()));
}

class RootAppWidget extends ConsumerWidget {
  const RootAppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final theme = ref.watch(themeProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      theme: theme.theme,
      debugShowCheckedModeBanner: false,
      builder: (_, child) {
        return AppStartupWidget(onLoaded: (_) => child!);
      },
    );
  }
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: Text('An error occurred'.hardcoded)),
      body: Center(child: Text(details.toString())),
    );
  };
}
