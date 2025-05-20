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
    // TODO error checking on device
    final characteristic = C.temperature;

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
          characteristic.icon,
          gapWMED,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [CharacteristicValueWidget(device: device), Text(device.label)],
          ),
        ],
      ),
    );
  }
}

class CharacteristicValueWidget extends ConsumerWidget {
  final Devices device;

  const CharacteristicValueWidget({required this.device, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceMap = ref.watch(deviceCharacteristicsProvider);
    debugPrint('info: ${deviceMap.toString()}');

    return AsyncValueWidget(
      value: deviceMap,
      data: (data) => Text('${data.deviceMap[device]} ${C.temperature.units}', style: TextStyles.h1),
    );
  }
}
