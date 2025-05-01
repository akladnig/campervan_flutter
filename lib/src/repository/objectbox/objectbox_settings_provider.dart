//This is for appStartup
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campervan/src/features/settings/settings_model.dart';
import 'package:campervan/src/features/settings/settings_provider.dart';
import 'package:campervan/src/repository/objectbox.dart';
import 'package:campervan/src/repository/objectbox/objectbox_settings_model.dart';
import 'package:campervan/src/utils/logging_provider.dart';
import 'package:logger/logger.dart';

Future<SettingsModel> obxLoadSettings(Ref ref) async {
  final logger = Logger(printer: ref.watch(logPrinterProvider));
  final settingsBox = await ref.read(settingsBoxProvider.future);

  SettingsModel settings;
  final row = settingsBox.get(1);
  logger.d(row.toString());

  if (row != null) {
    settings = row.toSettingsModel();
    await ref.read(settingsProvider.notifier).setAll(settings);
  } else {
    settings = ref.read(settingsProvider);
    settingsBox.put(settings.toObjectBox(0));
  }

  logger.d(settings);
  return settings;
}

extension ObxSettingsMapper on SettingsModel {
  ObxSettingsModel toObjectBox(int id) {
    return ObxSettingsModel(
      id: id,
      themeMode: themeMode,
      loggingLevel: loggingLevel,
      loggingPrinterDetail: loggingPrinterDetail,
      methodCount: methodCount,
    );
  }
}

/// Returns the rowId if the row does not exist or the number of rows updated.
/// In either case the value will be 1 if successful or 0 otherwise.
Future<int> obxSaveSettings(Ref ref) async {
  final logger = Logger(printer: ref.watch(logPrinterProvider));
  final settings = ref.watch(settingsProvider);
  final settingsBox = await ref.read(settingsBoxProvider.future);

  var result = 0;
  if (settingsBox.count() == 0) {
    result = settingsBox.put(settings.toObjectBox(0));
  } else {
    result = settingsBox.put(settings.toObjectBox(1));
  }
  logger.d('result: $result');
  return result;
}
