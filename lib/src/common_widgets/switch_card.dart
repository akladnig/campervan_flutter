import 'package:campervan/src/common_widgets/base_card.dart';
import 'package:campervan/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchCard extends ConsumerStatefulWidget {
  const SwitchCard({
    this.cardType = CardType.standard,
    this.borderTop = true,
    this.borderLeft = true,
    this.borderRight = true,
    this.borderBottom = true,
    required this.iconData,
    required this.title,
    super.key,
  });

  final CardType cardType;
  final bool borderTop;
  final bool borderLeft;
  final bool borderRight;
  final bool borderBottom;
  final IconData iconData;
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SwitchCardState();
}

class _SwitchCardState extends ConsumerState<SwitchCard> {
  var switchState = true;

  @override
  Widget build(BuildContext context) {
    final colour = switchState ? Colors.green : Colors.red;
    final icon = Icon(widget.iconData, color: colour, size: Sizes.iconLge);

    return BaseCard(
      cardType: CardType.standard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              icon,
              gapWMED,
              Switch(
                value: switchState,
                activeTrackColor: Colors.green,
                onChanged: (bool value) {
                  setState(() {
                    switchState = value;
                  });
                },
              ),
            ],
          ),
          gapHMED,
          Text(widget.title),
        ],
      ),
    );
  }
}
