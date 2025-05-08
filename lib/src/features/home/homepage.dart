import 'package:campervan/src/common_widgets/base_card.dart';
import 'package:campervan/src/common_widgets/info_card.dart';
import 'package:campervan/src/common_widgets/switch_card.dart';
import 'package:campervan/src/constants/app_sizes.dart';
import 'package:campervan/src/constants/theme.dart';
import 'package:campervan/src/features/arduino/arduino_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: OutlinedBox(
                  child: LayoutGrid(
                    areas: '''
                      at  b2i
                      bbt b2o
                    ''',
                    rowSizes: [auto, auto],
                    columnSizes: [auto, auto],
                    children: [
                      InfoCard(device: D.ambientTemperature, border: 'tl').inGridArea('at'),
                      InfoCard(device: D.battery2in, border: 'tr').inGridArea('b2i'),

                      InfoCard(device: D.batteryBoxTemperature, border: 'bl').inGridArea('bbt'),
                      InfoCard(device: D.battery2out, border: 'br').inGridArea('b2o'),
                    ],
                  ),
                ),
              ),
              SwitchCard(title: 'Battery 2', iconData: Icons.battery_std),
            ],
          ),
        ),
      ),
    );
  }
}

class OutlinedBox extends ConsumerWidget {
  const OutlinedBox({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardStyle = ref.watch(settingsProvider).cardStyle;

    final boxDecoration =
        cardStyle == CardStyle.outlined
            ? BoxDecoration(
              border: Border.all(color: primaryColour, width: Sizes.borderWidth),
              borderRadius: BorderRadius.circular(Sizes.medium + Sizes.borderWidth),
            )
            : null;

    return Container(margin: EdgeInsets.all(Sizes.margin), decoration: boxDecoration, child: child);
  }
}
