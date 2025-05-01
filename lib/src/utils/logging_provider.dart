import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/src/features/settings/settings_provider.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logging_provider.g.dart';

enum PrinterDetail { low, high }

@riverpod
LogPrinter logPrinter(Ref ref) {
  final printerDetail = ref.read(settingsProvider).loggingPrinterDetail;
  final methodCount = ref.read(settingsProvider).methodCount;
  return printerDetail == PrinterDetail.high
      ? PrettyPrinter(
        methodCount: methodCount,
        errorMethodCount: 5,
        lineLength: 80,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.none,
      )
      : SimplePrinter();
}
