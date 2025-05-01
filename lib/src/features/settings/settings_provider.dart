import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campervan/src/features/settings/settings_model.dart';
import 'package:campervan/src/repository/objectbox/objectbox_settings_provider.dart';
import 'package:campervan/src/utils/logging_provider.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

abstract class SettingsDef {
  Future<SettingsModel> setAll(SettingsModel settings);
  Future<Level> setLoggingLevel(Level level);
  Future<PrinterDetail> setLoggingPrinterDetail(PrinterDetail printerDetail);
  Future<int> setMethodCount(int methodCount);
  Future<ThemeMode> setThemeMode(ThemeMode themeMode);
}

@Riverpod(keepAlive: true)
class Settings extends _$Settings implements SettingsDef {
  @override
  SettingsModel build() {
    return SettingsModel();
  }

  @override
  Future<SettingsModel> setAll(SettingsModel settings) async {
    //TODO add checks e.g. methodCount
    state = settings;
    await ref.read(saveSettingsProvider.future);
    return state;
  }

  /// Sets the `level` to be used for logging and gets saved to the database.
  @override
  Future<Level> setLoggingLevel(Level level) async {
    state = state.copyWith(loggingLevel: level);
    Logger.level = state.loggingLevel;
    await ref.read(saveSettingsProvider.future);
    return state.loggingLevel;
  }

  /// Sets the `printerDetail` to be used for logging.
  /// `PrinterDetail.high` uses `prettyPrinter` and
  /// `PrinterDetails.low` uses `simplePrinter`.
  /// Gets saved to the database.
  @override
  Future<PrinterDetail> setLoggingPrinterDetail(PrinterDetail printerDetail) async {
    state = state.copyWith(loggingPrinterDetail: printerDetail);
    await ref.read(saveSettingsProvider.future);
    return state.loggingPrinterDetail;
  }

  /// Sets the `methodCount` to be displayed by the `logger`.
  /// By default displays a `methodCount` of 1.
  /// Gets saved to the database.
  @override
  Future<int> setMethodCount(int methodCount) async {
    state = state.copyWith(methodCount: methodCount.clamp(0, maxMethods));
    await ref.read(saveSettingsProvider.future);
    return state.methodCount;
  }

  /// Sets the `theme` to be used. By default uses the system theme and gets saved to the database.
  @override
  Future<ThemeMode> setThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);
    await ref.read(saveSettingsProvider.future);
    return state.themeMode;
  }
}

@riverpod
Future<int> saveSettings(Ref ref) async {
  return obxSaveSettings(ref);
}

@riverpod
Future<SettingsModel> loadSettings(Ref ref) async {
  return obxLoadSettings(ref);
}
