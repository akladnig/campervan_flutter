import 'package:flutter/material.dart';

/// Constant sizes to be used in the app (paddings, gaps, rounded corners etc.)
/// Based on a consistent Ratio of 1.25
/// `baseSize    14      16      20`
/// xxsmall     7.2     8.2     10.2
/// xsmall      9.0     10.2    12.8
/// small       11.2    12.8    16.0
/// medium      14.0    16.0    20.0
/// large       17.5    20.0    25.0
/// xLarge      21.9    25.0    31.3
/// x2Large     27.3    31.3    39.1
/// x3Large     34.2    39.1    48.8
/// x4Large     42.7    48.8    61.0
class Sizes {
  static const baseFontSize = 16.0;
  static const sizeRatio = 1.25;

  /// `strokeWidth `= `baseFontSize `/ 10
  static const double strokeWidth = x2Large / 10;

  // TODO work out difference in sizing between material icons and fontAwesome
  static const double iconFA = x3Large;
  static const double icon = x4Large;
  static const double iconLge = 2 * x4Large;

  static const double padding = medium / 2;
  static const double margin = medium / 4;
  static const double borderWidth = medium / 4;

  static const double none = 0.0;
  static const double xxSmall = xSmall / sizeRatio;
  static const double xSmall = small / sizeRatio;
  static const double small = medium / sizeRatio;

  /// `medium` is the baseFontSize (16)
  static const double medium = baseFontSize;
  static const double large = medium * sizeRatio;
  static const double xLarge = large * sizeRatio;
  static const double x2Large = xLarge * sizeRatio;
  static const double x3Large = x2Large * sizeRatio;
  static const double x4Large = x3Large * sizeRatio;
}

/// Constant gap widths
const gapWXS = SizedBox(width: Sizes.xSmall);
const gapWSML = SizedBox(width: Sizes.small);
const gapWMED = SizedBox(width: Sizes.medium);
const gapWLGE = SizedBox(width: Sizes.large);
const gapWXLG = SizedBox(width: Sizes.xLarge);

/// Constant gap heights
const gapHXXS = SizedBox(height: Sizes.xxSmall);
const gapHXS = SizedBox(height: Sizes.xSmall);
const gapHSML = SizedBox(height: Sizes.small);
const gapHMED = SizedBox(height: Sizes.medium);
const gapHLGE = SizedBox(height: Sizes.large);
const gapHXLG = SizedBox(height: Sizes.xLarge);
