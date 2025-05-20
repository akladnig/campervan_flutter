import 'package:campervan/src/constants/app_sizes.dart';
import 'package:campervan/src/features/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CardStyle { elevated, filled, outlined }

/// `summary` is a small rectangular card with 2-3 items shown
/// `standard` is s medium almost square card with 2-3 items shown
/// `detailed` a larger squarish card with space for additional items such as sliders or progress indicators
enum CardType {
  summary(width: 250, height: 100),
  standard(width: 250, height: 250),
  detailed(width: 250, height: 400);

  final double width;
  final double height;
  const CardType({required this.width, required this.height});
}

enum CardBorder { top, right, bottom, left }

/// BaseCard is the base used by cards such as InfoCard, SwitchCard, ProgressIndicatorCard etc.
/// The BaseCard can be displayed as a single widget or can be butted up against other cards, so
/// `Border` is used to set the card Border Style.
class BaseCard extends ConsumerWidget {
  const BaseCard({
    this.cardType = CardType.summary,
    this.borderTop = true,
    this.borderLeft = true,
    this.borderRight = true,
    this.borderBottom = true,
    required this.child,
    super.key,
  });

  final CardType cardType;
  final bool borderTop;
  final bool borderLeft;
  final bool borderRight;
  final bool borderBottom;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final cardStyle = settings.cardStyle;
    final bool isOutlined = cardStyle == CardStyle.outlined;

    double marginLeft = borderLeft && !isOutlined ? Sizes.margin : 0.0;
    double marginTop = borderTop && !isOutlined ? Sizes.margin : 0.0;
    double marginRight = borderRight && !isOutlined ? Sizes.margin : 0.0;
    double marginBottom = borderBottom && !isOutlined ? Sizes.margin : 0.0;

    double topLeftRadius = borderTop && borderLeft ? Sizes.medium : Sizes.none;
    double topRightRadius = borderTop && borderRight ? Sizes.medium : Sizes.none;
    double bottomLeftRadius = borderBottom && borderLeft ? Sizes.medium : Sizes.none;
    double bottomRightRadius = borderBottom && borderRight ? Sizes.medium : Sizes.none;

    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(marginLeft, marginTop, marginRight, marginBottom),
        child: Card(
          margin: EdgeInsets.all(0.0),
          color: Colors.white12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius),
              topRight: Radius.circular(topRightRadius),
              bottomLeft: Radius.circular(bottomLeftRadius),
              bottomRight: Radius.circular(bottomRightRadius),
            ),
          ),
          child: SizedBox(
            width: cardType.width,
            height: cardType.height,
            child: Padding(padding: EdgeInsets.all(Sizes.padding), child: child),
          ),
        ),
      ),
    );
  }
}
