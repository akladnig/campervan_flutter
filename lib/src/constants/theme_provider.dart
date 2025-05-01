import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:campervan/src/constants/theme.dart';
import 'package:campervan/src/features/settings/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  AppTheme build() {
    var themeMode = ref.watch(settingsProvider).themeMode;
    return AppTheme(themeMode);
  }

  /// Toggles the theme from dark to light and vice-versa
  /// If the themeMode is system, it will set it to dark
  /// but will not change the themeMode itself
  toggleTheme() {
    var themeMode = state.themeMode;

    switch (themeMode) {
      case ThemeMode.dark:
        state = AppTheme(ThemeMode.light);
        break;
      case ThemeMode.light:
        state = AppTheme(ThemeMode.dark);
        break;
      case ThemeMode.system:
        if (isDarkMode()) {
          state = AppTheme(ThemeMode.light);
        } else {
          state = AppTheme(ThemeMode.dark);
        }
    }
    ref.read(settingsProvider.notifier).setThemeMode(state.themeMode);
  }

  setTheme(ThemeMode? theme) {
    state = theme != null ? AppTheme(theme) : AppTheme(ThemeMode.system);
  }

  bool isDarkMode() {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }
}
