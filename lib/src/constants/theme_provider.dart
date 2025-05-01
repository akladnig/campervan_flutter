import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:template/src/constants/theme.dart';
import 'package:template/src/features/settings/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  TemplateTheme build() {
    var themeMode = ref.watch(settingsProvider).themeMode;
    return TemplateTheme(themeMode);
  }

  /// Toggles the theme from dark to light and vice-versa
  /// If the themeMode is system, it will set it to dark
  /// but will not change the themeMode itself
  toggleTheme() {
    var themeMode = state.themeMode;

    switch (themeMode) {
      case ThemeMode.dark:
        state = TemplateTheme(ThemeMode.light);
        break;
      case ThemeMode.light:
        state = TemplateTheme(ThemeMode.dark);
        break;
      case ThemeMode.system:
        if (isDarkMode()) {
          state = TemplateTheme(ThemeMode.light);
        } else {
          state = TemplateTheme(ThemeMode.dark);
        }
    }
    ref.read(settingsProvider.notifier).setThemeMode(state.themeMode);
  }

  setTheme(ThemeMode? theme) {
    state = theme != null ? TemplateTheme(theme) : TemplateTheme(ThemeMode.system);
  }

  bool isDarkMode() {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }
}
