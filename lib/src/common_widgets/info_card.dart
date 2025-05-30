import 'package:campervan/src/common_widgets/async_value_widget.dart';
import 'package:campervan/src/common_widgets/base_card.dart';
import 'package:campervan/src/constants/app_sizes.dart';
import 'package:campervan/src/constants/theme.dart';
import 'package:campervan/src/features/arduino/arduino_model.dart';
import 'package:campervan/src/features/arduino/arduino_web_socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// `border` is a simple string of any combination of `tlbr` -  any other characters are simply
/// ignored.
class InfoCard extends ConsumerWidget {
  final Devices device;
  final String border;

  const InfoCard({required this.device, required this.border, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool borderTop = border.contains('t');
    bool borderRight = border.contains('r');
    bool borderBottom = border.contains('b');
    bool borderLeft = border.contains('l');

    return BaseCard(
      borderTop: borderTop,
      borderRight: borderRight,
      borderBottom: borderBottom,
      borderLeft: borderLeft,

      child: Row(
        children: [
          CharacteristicIcon(device: device),
          gapWMED,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [CharacteristicValue(device: device), Text(device.label)],
          ),
        ],
      ),
    );
  }
}

class CharacteristicValue extends ConsumerWidget {
  final Devices device;

  const CharacteristicValue({required this.device, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceMap = ref.watch(deviceCharacteristicsProvider);
    // debugPrint('info: ${deviceMap.toString()}');

    return AsyncValueWidget(
      value: deviceMap,
      data:
          (data) =>
              Text('${data.value(device)} ${data.units(device)}', style: TextStyles.h1),
      skipLoadingOnReload: true,
    );
  }
}

class CharacteristicIcon extends ConsumerWidget {
  final Devices device;

  const CharacteristicIcon({required this.device, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceMap = ref.watch(deviceCharacteristicsProvider);

    return AsyncValueWidget(
      value: deviceMap,
      data: (data) => data.icon(device),
      skipLoadingOnReload: true,
    );
  }
}
