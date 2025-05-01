import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campervan/src/common_widgets/app_bar.dart';
import 'package:campervan/src/constants/app_sizes.dart';
import 'package:campervan/src/constants/theme.dart';
import 'package:campervan/src/constants/theme_provider.dart';
import 'package:campervan/src/features/settings/settings_model.dart';
import 'package:campervan/src/features/settings/settings_provider.dart';
import 'package:campervan/src/utils/logging_provider.dart';
import 'package:campervan/src/utils/string_extension.dart';
import 'package:logger/logger.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

enum InterfaceLanguage { english, italian }

class _SettingsViewState extends ConsumerState<SettingsView> {
  ThemeMode? theme;

  @override
  Widget build(BuildContext context) {
    ref.watch(themeProvider);
    theme = ref.watch(themeProvider).themeMode;
    ref.watch(settingsProvider);
    return Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(80.0), child: AppBarWidget(title: 'Settings')),
      body: SafeArea(
        child: Container(
          width: 800,
          // width: Breakpoint.tablet,
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              gapHMED,
              ThemeDropdown(),
              gapHMED,
              GroupSettings(
                labelText: 'Development',
                child: Column(
                  children: [
                    LoggingLevelDropdown(),
                    gapHMED,
                    LoggingPrinterDetailDropdown(),
                    gapHMED,
                    MethodCountDropdown(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupSettings extends StatelessWidget {
  const GroupSettings({super.key, required this.labelText, required this.child});
  final String labelText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      child: child,
    );
  }
}

class ThemeDropdown extends ConsumerStatefulWidget {
  const ThemeDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ThemeDropdownState();
}

class _ThemeDropdownState extends ConsumerState<ThemeDropdown> {
  ThemeMode? selectedTheme;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(settingsProvider).themeMode;

    final List<DropdownMenuEntry<ThemeMode>> themeDropdownEntries = <DropdownMenuEntry<ThemeMode>>[];
    for (final ThemeMode themeMode in ThemeMode.values) {
      themeDropdownEntries.add(
        DropdownMenuEntry<ThemeMode>(value: themeMode, label: themeMode.name.toString().capitalise),
      );
    }
    return DropdownMenu<ThemeMode>(
      initialSelection: themeMode,
      label: const Text('Theme'),
      width: SettingsStyle.width,
      dropdownMenuEntries: themeDropdownEntries,
      onSelected: (ThemeMode? value) {
        ref.read(settingsProvider.notifier).setThemeMode(value!);
        setState(() {
          selectedTheme = value;
        });
      },
    );
  }
}

class LoggingLevelDropdown extends ConsumerStatefulWidget {
  const LoggingLevelDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoggingLevelDropdownState();
}

class LoggingLevelDropdownState extends ConsumerState<LoggingLevelDropdown> {
  Level? selectedLoggingLevel;

  @override
  Widget build(BuildContext context) {
    final loggingLevel = ref.watch(settingsProvider).loggingLevel;

    final List<DropdownMenuEntry<Level>> loggingLevelEntries = <DropdownMenuEntry<Level>>[];
    for (final level in Level.values) {
      loggingLevelEntries.add(DropdownMenuEntry<Level>(value: level, label: level.name.capitalise));
    }
    return DropdownMenu<Level>(
      initialSelection: loggingLevel,
      label: const Text('Logging Level'),
      width: SettingsStyle.width,
      dropdownMenuEntries: loggingLevelEntries,
      onSelected: (Level? value) {
        ref.read(settingsProvider.notifier).setLoggingLevel(value!);
        setState(() {
          selectedLoggingLevel = value;
        });
      },
    );
  }
}

class LoggingPrinterDetailDropdown extends ConsumerStatefulWidget {
  const LoggingPrinterDetailDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoggingPrinterDetailDropdownState();
}

class LoggingPrinterDetailDropdownState extends ConsumerState<LoggingPrinterDetailDropdown> {
  PrinterDetail? selectedLoggingPrinterDetail;

  @override
  Widget build(BuildContext context) {
    final loggingPrinterDetail = ref.watch(settingsProvider).loggingPrinterDetail;

    final List<DropdownMenuEntry<PrinterDetail>> loggingPrinterDetailEntries = <DropdownMenuEntry<PrinterDetail>>[];
    for (final level in PrinterDetail.values) {
      loggingPrinterDetailEntries.add(DropdownMenuEntry<PrinterDetail>(value: level, label: level.name.capitalise));
    }
    return DropdownMenu<PrinterDetail>(
      initialSelection: loggingPrinterDetail,
      label: const Text('Logging Printer Detail'),
      width: SettingsStyle.width,
      dropdownMenuEntries: loggingPrinterDetailEntries,
      onSelected: (PrinterDetail? value) {
        ref.read(settingsProvider.notifier).setLoggingPrinterDetail(value!);
        setState(() {
          selectedLoggingPrinterDetail = value;
        });
      },
    );
  }
}

class MethodCountDropdown extends ConsumerStatefulWidget {
  const MethodCountDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MethodCountDropdownState();
}

class MethodCountDropdownState extends ConsumerState<MethodCountDropdown> {
  int? selectedMethodCount;

  @override
  Widget build(BuildContext context) {
    final methodCount = ref.watch(settingsProvider).methodCount;

    final List<DropdownMenuEntry<int>> methodCountEntries = <DropdownMenuEntry<int>>[];
    for (var count = 0; count <= maxMethods; count++) {
      methodCountEntries.add(DropdownMenuEntry<int>(value: count, label: count.toString()));
    }
    return DropdownMenu<int>(
      initialSelection: methodCount,
      label: const Text('Method Count'),
      width: SettingsStyle.width,
      dropdownMenuEntries: methodCountEntries,
      onSelected: (int? value) {
        ref.read(settingsProvider.notifier).setMethodCount(value!);
        setState(() {
          selectedMethodCount = value;
        });
      },
    );
  }
}
