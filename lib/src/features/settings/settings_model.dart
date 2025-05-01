import 'package:flutter/material.dart';
import 'package:campervan/src/utils/logging_provider.dart';
import 'package:logger/logger.dart';

const maxMethods = 5;

/// `colouredBlock` uses a matching background colour and lighter colour for text
/// `plainBlock` uses the foreground colour for text with background colour
/// `contrastBlock` uses a constrating background colour
enum HighlightStyle { plainBlock, colouredBlock, contrastBlock, underline, none }

final class SettingsModel {
  const SettingsModel({
    this.themeMode = ThemeMode.system,
    this.loggingLevel = Level.debug,
    this.loggingPrinterDetail = PrinterDetail.high,
    this.methodCount = 1,
  });

  final ThemeMode themeMode;
  final Level loggingLevel;
  final PrinterDetail loggingPrinterDetail;
  final int methodCount;

  SettingsModel copyWith({
    ThemeMode? themeMode,
    Level? loggingLevel,
    PrinterDetail? loggingPrinterDetail,
    int? methodCount,
  }) {
    return SettingsModel(
      themeMode: themeMode ?? this.themeMode,
      loggingLevel: loggingLevel ?? this.loggingLevel,
      loggingPrinterDetail: loggingPrinterDetail ?? this.loggingPrinterDetail,
      methodCount: methodCount ?? this.methodCount,
    );
  }

  @override
  String toString() {
    return ('SettingsModel(themeMode: $themeMode, '
        'loggingLevel: $loggingLevel, '
        'loggingPrinterDetail: $loggingPrinterDetail, '
        'methodCount: $methodCount'
        ')');
  }
}
