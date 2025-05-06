import 'package:campervan/src/common_widgets/base_card.dart';
import 'package:campervan/src/common_widgets/info_card.dart';
import 'package:campervan/src/common_widgets/switch_card.dart';
import 'package:campervan/src/features/arduino/arduino_model.dart';
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

// TODO fix rebuild - add additional widget
class _HomePageState extends ConsumerState<HomePage> {
  ThemeMode? theme;

  @override
  Widget build(BuildContext context) {
    theme = ref.watch(themeProvider).themeMode;
    ref.watch(settingsProvider);
    final devices = ref.watch(deviceMapProvider);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBarWidget(title: 'Camper Van Dashboard'),
      ),
      body: SafeArea(
        child: Container(
          width: 1000,
          // width: Breakpoint.tablet,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  InfoCard(device: D.ambientTemperature, borderRight: false, borderBottom: false),
                  InfoCard(device: D.battery2in, borderLeft: false, borderBottom: false),
                ],
              ),

              Row(
                children: [
                  InfoCard(device: D.batteryBoxTemperature, borderRight: false, borderTop: false),
                  InfoCard(device: D.battery2out, borderLeft: false, borderTop: false),
                ],
              ),
              SwitchCard(title: 'Battery 2', iconData: Icons.battery_std),
            ],
          ),
        ),
      ),
    );
  }
}
