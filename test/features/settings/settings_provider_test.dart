import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campervan/src/constants/theme_provider.dart';
import 'package:campervan/src/features/settings/settings_model.dart';
import 'package:campervan/src/features/settings/settings_provider.dart';
import 'package:campervan/src/repository/objectbox.dart';
import 'package:campervan/src/utils/logging_provider.dart';
import 'package:campervan/src/utils/testing_provider.dart';
import 'package:logger/logger.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(parent: parent, overrides: overrides, observers: observers);
  Logger.level = Level.off;
  // container.read(isTestingProvider.notifier).set(true, inMemory: false);
  container.read(isTestingProvider.notifier).set(true, inMemory: true);

  addTearDown(container.dispose);

  return container;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Settings Provider tests', () {
    test('Settings provider constructor test', () {
      // Create a ProviderContainer for this test.
      // DO NOT share ProviderContainers between tests.
      final container = createContainer();
      expect(
        container.read(settingsProvider).toString(),
        'SettingsModel(themeMode: ThemeMode.system, cardStyle: CardStyle.elevated, loggingLevel: Level.debug, loggingPrinterDetail: PrinterDetail.high, methodCount: 1)',
      );
    });

    test('Settings provider constructor SetMode(dark)', () async {
      final container = createContainer();
      await container.read(settingsProvider.notifier).setThemeMode(ThemeMode.dark);
      final e1 = expectLater(
        container.read(settingsProvider).toString(),
        'SettingsModel(themeMode: ThemeMode.dark, cardStyle: CardStyle.elevated, loggingLevel: Level.debug, loggingPrinterDetail: PrinterDetail.high, methodCount: 1)',
      );
      expect(container.read(themeProvider).themeMode, ThemeMode.dark);

      await e1;
      // await container.read(databaseProvider).close();
      container.read(objectBoxProvider.notifier).closeStore();
    });

    test('Settings provider constructor SetMode()', () async {
      final container = createContainer();
      await container.read(settingsProvider.notifier).setThemeMode(ThemeMode.system);

      expect(
        container.read(settingsProvider).toString(),
        'SettingsModel(themeMode: ThemeMode.system, cardStyle: CardStyle.elevated, loggingLevel: Level.debug, loggingPrinterDetail: PrinterDetail.high, methodCount: 1)',
      );
      expect(container.read(themeProvider).themeMode, ThemeMode.system);
      // await container.read(databaseProvider).close();
      container.read(objectBoxProvider.notifier).closeStore();
    });

    test('Settings provider loggingLevel - trace', () async {
      final container = createContainer();
      final result = await container.read(settingsProvider.notifier).setLoggingLevel(Level.trace);
      expect(result, Level.trace);
      await container.read(loadSettingsProvider.future);
      final result2 = container.read(settingsProvider);
      expect(result2.loggingLevel, Level.trace);
      // await container.read(databaseProvider).close();
      container.read(objectBoxProvider.notifier).closeStore();
    });

    test('Settings provider loggingPrinterDetails - low', () async {
      final container = createContainer();
      final result = await container.read(settingsProvider.notifier).setLoggingPrinterDetail(PrinterDetail.low);
      expect(result, PrinterDetail.low);
      await container.read(loadSettingsProvider.future);
      final result2 = container.read(settingsProvider);
      expect(result2.loggingPrinterDetail, PrinterDetail.low);
      // await container.read(databaseProvider).close();
      container.read(objectBoxProvider.notifier).closeStore();
    });

    test('Settings provider methodCount - 3', () async {
      final container = createContainer();
      final result = await container.read(settingsProvider.notifier).setMethodCount(3);
      expect(result, 3);
      await container.read(loadSettingsProvider.future);
      final result2 = container.read(settingsProvider);
      expect(result2.methodCount, 3);
      // await container.read(databaseProvider).close();
      container.read(objectBoxProvider.notifier).closeStore();
    });

    test('Settings provider methodCount - -1 should clamp to 0', () async {
      final container = createContainer();
      final result = await container.read(settingsProvider.notifier).setMethodCount(-1);
      expect(result, 0);
      // await container.read(databaseProvider).close();
      container.read(objectBoxProvider.notifier).closeStore();
    });

    test('Settings provider methodCount - 8 should clamp to maxMethods (5)', () async {
      final container = createContainer();
      final result = await container.read(settingsProvider.notifier).setMethodCount(8);
      expect(result, maxMethods);
      await container.read(loadSettingsProvider.future);
      final result2 = container.read(settingsProvider);
      expect(result2.methodCount, maxMethods);
      // await container.read(databaseProvider).close();
      container.read(objectBoxProvider.notifier).closeStore();
    });

    test('Settings provider setAll and settings', () async {
      final container = createContainer();

      await container
          .read(settingsProvider.notifier)
          .setAll(
            SettingsModel(
              themeMode: ThemeMode.dark,
              loggingLevel: Level.trace,
              loggingPrinterDetail: PrinterDetail.low,
              methodCount: 5,
            ),
          );

      expect(
        container.read(settingsProvider).toString(),
        'SettingsModel(themeMode: ThemeMode.dark, cardStyle: CardStyle.elevated, loggingLevel: Level.trace, loggingPrinterDetail: PrinterDetail.low, methodCount: 5)',
      );
      expect(container.read(themeProvider).themeMode, ThemeMode.dark);

      // await container.read(databaseProvider).close();
      container.read(objectBoxProvider.notifier).closeStore();
    });

    test('Settings Provider getSettings', () async {
      final container = createContainer();

      await container.read(settingsProvider.notifier).setAll(SettingsModel(themeMode: ThemeMode.light));
      expect(
        container.read(settingsProvider).toString(),
        'SettingsModel(themeMode: ThemeMode.light, cardStyle: CardStyle.elevated, loggingLevel: Level.debug, loggingPrinterDetail: PrinterDetail.high, methodCount: 1)',
      );

      await container.read(saveSettingsProvider.future);

      await container.read(settingsProvider.notifier).setAll(SettingsModel(themeMode: ThemeMode.dark));

      expect(
        container.read(settingsProvider).toString(),
        'SettingsModel(themeMode: ThemeMode.dark, cardStyle: CardStyle.elevated, loggingLevel: Level.debug, loggingPrinterDetail: PrinterDetail.high, methodCount: 1)',
      );

      container.read(loadSettingsProvider);

      expect(
        container.read(settingsProvider).toString(),
        'SettingsModel(themeMode: ThemeMode.dark, cardStyle: CardStyle.elevated, loggingLevel: Level.debug, loggingPrinterDetail: PrinterDetail.high, methodCount: 1)',
      );

      await container.read(settingsProvider.notifier).setAll(SettingsModel(themeMode: ThemeMode.dark));
    });
  });
}
