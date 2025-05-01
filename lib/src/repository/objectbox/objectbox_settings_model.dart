import 'package:flutter/material.dart';
import 'package:template/src/features/settings/settings_model.dart';
import 'package:template/src/utils/logging_provider.dart';
import 'package:logger/logger.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
final class ObxSettingsModel {
  ObxSettingsModel({
    this.id = 0,
    this.themeMode = ThemeMode.system,
    this.loggingLevel = Level.debug,
    this.loggingPrinterDetail = PrinterDetail.high,
    this.methodCount = 1,
  });

  int id;
  @Transient()
  ThemeMode themeMode;
  @Transient()
  Level loggingLevel;
  @Transient()
  PrinterDetail loggingPrinterDetail;
  int methodCount;
  @Transient()
  int get obxThemeMode {
    return themeMode.index;
  }

  set obxThemeMode(int index) {
    themeMode = ThemeMode.values[index];
  }

  int get obxLoggingLevel {
    return loggingLevel.index;
  }

  set obxLoggingLevel(int index) {
    loggingLevel = Level.values[index];
  }

  int get obxPrinterDetail {
    return loggingPrinterDetail.index;
  }

  set obxPrinterDetail(int index) {
    loggingPrinterDetail = PrinterDetail.values[index];
  }

  SettingsModel toSettingsModel() {
    return SettingsModel(
      themeMode: themeMode,
      loggingLevel: loggingLevel,
      loggingPrinterDetail: loggingPrinterDetail,
      methodCount: methodCount,
    );
  }
}
