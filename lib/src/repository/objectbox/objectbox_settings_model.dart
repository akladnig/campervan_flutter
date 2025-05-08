import 'package:campervan/src/common_widgets/base_card.dart';
import 'package:flutter/material.dart';
import 'package:campervan/src/features/settings/settings_model.dart';
import 'package:campervan/src/utils/logging_provider.dart';
import 'package:logger/logger.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
final class ObxSettingsModel {
  ObxSettingsModel({
    this.id = 0,
    this.themeMode = ThemeMode.system,
    this.cardStyle = CardStyle.outlined,
    this.loggingLevel = Level.debug,
    this.loggingPrinterDetail = PrinterDetail.high,
    this.methodCount = 1,
  });

  int id;
  @Transient()
  ThemeMode themeMode;
  @Transient()
  CardStyle cardStyle;
  @Transient()
  Level loggingLevel;
  @Transient()
  PrinterDetail loggingPrinterDetail;
  int methodCount;

  int get obxThemeMode {
    return themeMode.index;
  }

  set obxThemeMode(int index) {
    themeMode = ThemeMode.values[index];
  }

  int get obxCardStyle {
    return cardStyle.index;
  }

  set obxCardStyle(int index) {
    cardStyle = CardStyle.values[index];
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
      cardStyle: cardStyle,
      loggingLevel: loggingLevel,
      loggingPrinterDetail: loggingPrinterDetail,
      methodCount: methodCount,
    );
  }
}
