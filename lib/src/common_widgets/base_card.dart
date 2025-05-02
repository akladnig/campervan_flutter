import 'package:campervan/src/constants/app_sizes.dart';
import 'package:campervan/src/constants/theme.dart';
import 'package:flutter/material.dart';

enum CardStyle { elevated, filled, outlined }

/// `summary` is a small rectangular card with 2-3 items shown
/// `standard` is s medium almost square card with 2-3 items shown
/// `detailed` a larger squarish card with space for additional items such as sliders or progress indicators
enum CardType { summary, standard, detailed }

enum CardBorder { top, right, bottom, left }

/// BaseCard is the base used by cards such as InfoCard, SwitchCard, ProgressIndicatorCard etc.
/// The BaseCard can be displayed as a single widget or can be butted up against other cards, so
/// `Border` is used to set the card Border Style.
class BaseCard extends StatelessWidget {
  const BaseCard({
    // TODO from settings
    this.cardStyle = CardStyle.outlined,
    this.cardType = CardType.summary,
    this.borderTop = true,
    this.borderLeft = true,
    this.borderRight = true,
    this.borderBottom = true,
    required this.child,
    super.key,
  });

  final CardStyle cardStyle;
  final CardType cardType;
  final bool borderTop;
  final bool borderLeft;
  final bool borderRight;
  final bool borderBottom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double marginLeft = borderLeft ? Sizes.margin : 0.0;
    double marginTop = borderTop ? Sizes.margin : 0.0;
    double marginRight = borderRight ? Sizes.margin : 0.0;
    double marginBottom = borderBottom ? Sizes.margin : 0.0;

    double borderWidthLeft = 0.0;
    double borderWidthTop = 0.0;
    double borderWidthRight = 0.0;
    double borderWidthBottom = 0.0;

    if (borderLeft) {
      marginLeft = Sizes.margin;
      borderWidthLeft = Sizes.borderWidth;
    }
    if (borderTop) {
      marginTop = Sizes.margin;
      borderWidthTop = Sizes.borderWidth;
    }
    if (borderRight) {
      marginRight = Sizes.margin;
      borderWidthRight = Sizes.borderWidth;
    }
    if (borderBottom) {
      marginBottom = Sizes.margin;
      borderWidthBottom = Sizes.borderWidth;
    }

    BorderSide borderSideLeft = BorderSide(color: primaryColour, width: borderWidthLeft);
    BorderSide borderSideTop = BorderSide(color: primaryColour, width: borderWidthTop);
    BorderSide borderSideRight = BorderSide(color: primaryColour, width: borderWidthRight);
    BorderSide borderSideBottom = BorderSide(color: primaryColour, width: borderWidthBottom);

    Radius topLeft = Radius.circular(Sizes.none);
    Radius topRight = Radius.circular(Sizes.none);
    Radius bottomLeft = Radius.circular(Sizes.none);
    Radius bottomRight = Radius.circular(Sizes.none);

    if (borderTop && borderRight) topRight = Radius.circular(Sizes.medium);
    if (borderRight && borderBottom) bottomRight = Radius.circular(Sizes.medium);
    if (borderBottom && borderLeft) bottomLeft = Radius.circular(Sizes.medium);
    if (borderLeft && borderTop) topLeft = Radius.circular(Sizes.medium);

    switch (cardStyle) {
      case CardStyle.elevated:
        return Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(marginLeft, marginTop, marginRight, marginBottom),
            child: Card(
              margin: EdgeInsets.all(1.0),
              color: Colors.white12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: topLeft,
                  topRight: topRight,
                  bottomLeft: bottomLeft,
                  bottomRight: bottomRight,
                ),
              ),
              child: SizedBox(
                width: 250,
                height: 100,
                child: Padding(padding: EdgeInsets.all(Sizes.padding), child: child),
              ),
            ),
          ),
        );

      case CardStyle.filled:
        return Card.filled(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.medium)),
          child: SizedBox(width: 300, height: 200, child: child),
        );

      case CardStyle.outlined:
        return Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(marginLeft, marginTop, marginRight, marginBottom),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: topLeft,
                topRight: topRight,
                bottomLeft: bottomLeft,
                bottomRight: bottomRight,
              ),
              child: Card(
                margin: EdgeInsets.all(0.0),
                color: Colors.white12,
                shape: Border(
                  top: borderSideTop,
                  right: borderSideRight,
                  bottom: borderSideBottom,
                  left: borderSideLeft,
                ),
                child: SizedBox(width: 200, height: 200, child: Text('Card1')),
              ),
            ),
          ),
        );
    }
  }
}
