import 'package:campervan/src/common_widgets/base_card.dart';
import 'package:campervan/src/constants/app_sizes.dart';
import 'package:campervan/src/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum InfoType {
  temperature(
    label: 'temperature',
    units: '°C',
    icon: Icon(FontAwesomeIcons.temperatureThreeQuarters, size: Sizes.iconFA),
  ),
  voltage(label: 'voltage', units: 'V', icon: Icon(Icons.battery_std, size: Sizes.icon)),
  amperage(label: 'amperage', units: 'A', icon: Icon(Icons.battery_std, size: Sizes.icon)),
  percentage(label: 'percentage', units: '%', icon: Icon(Icons.percent, size: Sizes.icon)),
  kwH(label: 'kwH', units: 'kwH', icon: Icon(Icons.bolt, size: Sizes.icon));

  final String label;
  final String units;
  final Icon icon;

  const InfoType({required this.label, required this.units, required this.icon});
}

class InfoCard extends BaseCard {
  final double value;
  final String description;
  final InfoType infoType;

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
  }) : super(infoType: InfoType.temperature, value: temperature);
}
