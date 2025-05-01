import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campervan/src/constants/theme_provider.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(parent: parent, overrides: overrides, observers: observers);

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Theme Provider tests', () {
    test('Theme provider constructor test', () {
      // Create a ProviderContainer for this test.
      // DO NOT share ProviderContainers between tests.
      final container = createContainer();
      container.read(themeProvider.notifier).setTheme(null);
      expect(container.read(themeProvider).themeMode, ThemeMode.system);
    });

    test('Theme provider constructor test system', () {
      final container = createContainer();
      container.read(themeProvider.notifier).setTheme(ThemeMode.system);
      expect(container.read(themeProvider).themeMode, ThemeMode.system);
    });

    test('Theme provider constructor test toggle', () {
      final container = createContainer();
      container.read(themeProvider.notifier).setTheme(ThemeMode.dark);
      container.read(themeProvider.notifier).toggleTheme();
      expect(container.read(themeProvider).themeMode, ThemeMode.light);
      container.read(themeProvider.notifier).toggleTheme();
      expect(container.read(themeProvider).themeMode, ThemeMode.dark);
      container.read(themeProvider.notifier).setTheme(ThemeMode.system);
      expect(container.read(themeProvider).themeMode, ThemeMode.system);
      container.read(themeProvider.notifier).toggleTheme();
      if (container.read(themeProvider.notifier).isDarkMode()) {
        expect(container.read(themeProvider).themeMode, ThemeMode.light);
      } else {
        expect(container.read(themeProvider).themeMode, ThemeMode.dark);
      }
    });
  });
}
