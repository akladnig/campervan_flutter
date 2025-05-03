import 'package:campervan/src/common_widgets/base_card.dart';
import 'package:campervan/src/constants/app_sizes.dart';
import 'package:campervan/src/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchCard2 extends BaseCard {
  final Icon icon;
  final String title;

  SwitchCard2({
    super.cardStyle,
    super.cardType = CardType.standard,
    super.borderTop,
    super.borderLeft,
    super.borderRight,
    super.borderBottom,
    required this.icon,
    required this.title,
    super.key,
  }) : super(
         child: Column(
           children: [
             Row(children: [icon, gapWMED, Switch(value: true, onChanged: (value) {})]),
             gapHMED,
             Text(title),
           ],
         ),
       );
}

class SwitchCard extends ConsumerStatefulWidget {
  const SwitchCard({
    this.cardStyle = CardStyle.elevated,
    this.cardType = CardType.standard,
    this.borderTop = true,
    this.borderLeft = true,
    this.borderRight = true,
    this.borderBottom = true,
    required this.iconData,
    required this.title,
    super.key,
  });

  final CardStyle cardStyle;
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
  bool switchState = true;

  @override
  Widget build(BuildContext context) {
    final icon =
        switchState
            ? Icon(widget.iconData, color: Colors.green, size: Sizes.iconLge)
            : Icon(widget.iconData, color: Colors.red, size: Sizes.iconLge);
    return BaseCard(
      cardType: CardType.standard,
      child: Column(
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
