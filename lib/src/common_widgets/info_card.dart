import 'package:campervan/src/common_widgets/base_card.dart';
import 'package:campervan/src/constants/app_sizes.dart';
import 'package:campervan/src/constants/theme.dart';
import 'package:campervan/src/features/arduino/arduino_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoCard extends ConsumerWidget {
  final Devices device;
  final bool borderTop;
  final bool borderLeft;
  final bool borderRight;
  final bool borderBottom;

  const InfoCard({
    required this.device,
    this.borderTop = true,
    this.borderLeft = true,
    this.borderRight = true,
    this.borderBottom = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO error checking on device
    final deviceMap = ref.read(deviceMapProvider);
    final characteristic = deviceMap[device]!.keys.first;
    final value = deviceMap[device]!.values.first;

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
            children: [Text('${value.toString()} ${characteristic.units}', style: TextStyles.h1), Text(device.label)],
          ),
        ],
      ),
    );
  }
}
