import 'package:campervan/src/common_widgets/base_card.dart';
import 'package:campervan/src/constants/app_sizes.dart';
import 'package:campervan/src/constants/theme.dart';
import 'package:campervan/src/features/arduino/arduino_model.dart';
import 'package:flutter/material.dart';

class InfoCard extends BaseCard {
  final double value;
  final String description;
  final Characteristics infoType;

  InfoCard({
    super.cardStyle,
    super.cardType,
    super.borderTop,
    super.borderLeft,
    super.borderRight,
    super.borderBottom,
    required this.infoType,
    required this.value,
    required this.description,
    super.key,
  }) : super(
         child: Row(
           children: [
             infoType.icon,
             gapWMED,
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [Text('${value.toString()} ${infoType.units}', style: TextStyles.h1), Text(description)],
             ),
           ],
         ),
       );
}

class TemperatureCard extends InfoCard {
  final double temperature;

  TemperatureCard({
    super.cardStyle = CardStyle.outlined,
    super.cardType,
    super.borderTop,
    super.borderLeft = true,
    super.borderRight = true,
    super.borderBottom = true,
    required this.temperature,
    required super.description,
    super.key,
  }) : super(infoType: Characteristics.temperature, value: temperature);
}
