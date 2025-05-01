import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campervan/src/common_widgets/app_bar.dart';
import 'package:campervan/src/constants/theme_provider.dart';
import 'package:campervan/src/features/settings/settings_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

enum InterfaceLanguage { english, italian }

// TODO fix rebuild - add additional widget
class _HomePageState extends ConsumerState<HomePage> {
  ThemeMode? theme;

  @override
  Widget build(BuildContext context) {
    ref.watch(themeProvider);
    theme = ref.watch(themeProvider).themeMode;
    ref.watch(settingsProvider);
    return Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(80.0), child: AppBarWidget(title: 'HomePage')),
      body: SafeArea(
        child: Container(
          width: 800,
          // width: Breakpoint.tablet,
          padding: const EdgeInsets.all(20.0),
        ),
      ),
    );
  }
}
