import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:campervan/src/constants/app_sizes.dart';

const dark = true;
const light = false;

const showDivider = false;

const Color checkColor = Colors.white;
const Color hoverColor = Colors.black26;

const primaryColour = Color(0xFF6243b3);
// conColor primaryColour = Color(0xFF713CFF);
const primaryColourW300 = Color(0xFFf46c67);
const primaryColourW200 = Color(0xFFfb9792);
const primaryColourW100 = Color(0xFFffcbce);

/* pri*/
const primary0 = Color(0xFF000000);
const primary10 = Color(0xFF21005d);
const primary20 = Color(0xFF390f89);
const primary25 = Color(0xFF442094);
const primary30 = Color(0xFF502fa0);
const primary35 = Color(0xFF5c3cac);
const primary40 = Color(0xFF6849b9);
const primary50 = Color(0xFF8163d4);
const primary60 = Color(0xFF9c7df1);
const primary70 = Color(0xFFb59cff);
const primary80 = Color(0xFFcfbdff);
const primary90 = Color(0xFFe8ddff);
const primary95 = Color(0xFFf5eeff);
const primary98 = Color(0xFFfdf7ff);
const primary99 = Color(0xFFfffbff);
const primary100 = Color(0xFFffffff);

const Color menuColour = Colors.blue;

class ChartColours {
  static const Color primary = ChartColours.contentColorCyan;
  static const menuBackground = Color(0xFF090912);
  static const itemsBackground = Color(0xFF1B2339);
  static const pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color chartBorderColor = Colors.white10;
  static const gridLinesColor = Color(0x11FFFFFF);
  static const Color lineLegendBorderColor = Colors.white70;

  static const Color lineColorL = ChartColours.contentColorBlue;
  static const Color lineColorR = ChartColours.contentColorPurple;
  static const Color lineColor = ChartColours.contentColorRed;
  static const Color dotColor = ChartColours.contentColorRed;

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const contentColorBlue = Color(0xFF2196F3);
  static const contentColorYellow = Color(0xFFFFC300);
  static const contentColorOrange = Color(0xFFFF683B);
  static const contentColorGreen = Color(0xFF3BFF49);
  static const contentColorPurple = Color(0xFF6E1BFF);
  static const contentColorPink = Color(0xFFFF3AF2);
  static const contentColorRed = Color(0xFFE80054);
  static const contentColorCyan = Color(0xFF50E4FF);

  static const List<Color> gradientColorsL = [ChartColours.contentColorCyan, ChartColours.lineColorL];

  static const List<Color> gradientColorsR = [ChartColours.contentColorPink, ChartColours.contentColorPurple];
}

class HighlightColour {
  static const text = Color(0xFFDFDDE4);
  static const contrast = Color(0xFF6243B6);
  static const newWordText = Color(0xFF0BB3FE);
  static const newWordHighlight = Color(0xFF01587F);
  static const notKnownText = Color(0xFFFED00B);
  static const notKnownHighlight = Color(0xFF584700);
  static const familiarText = Color(0xFFFED00B);
  static const familiarHighlight = Color(0xFF896f01);
}

// Color foregroundColour = isDarkTheme ? Colors.white : Colors.black;
const Color foregroundColour = Colors.white;
const textColour = Color(0xFFDFDDE4);
const headerColour = Color(0xFFFED00B);

class Fonts {
  static const raleway = 'Raleway';
  // etc
}

class SettingsStyle {
  static const width = 200.0;
}

class TextStyles {
  static const raleway = TextStyle(fontFamily: Fonts.raleway);

  // Header Styles
  static const h1 = TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.xLarge);
  static const h2 = TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.large);
  static const h3 = TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.medium);
  static const h4 = TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.small);
  // Body Styles
  static const body = TextStyle(fontWeight: FontWeight.normal, fontSize: Sizes.medium, height: 1.4);
  // Height of 1 to allow precise positioning of text
  static const bodyHeightSmall = TextStyle(fontWeight: FontWeight.normal, fontSize: Sizes.medium, height: 1.0);
  static const bodySmallPrimary = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: Sizes.small,
    height: 1.4,
    color: primaryColourW300,
  );
  static const bodySmall = TextStyle(fontWeight: FontWeight.normal, fontSize: Sizes.small, height: 1.4);
  static const bodyBold = TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.medium, height: 1.4);
  static const error = TextStyle(fontWeight: FontWeight.normal, fontSize: Sizes.medium, height: 1.4, color: Colors.red);
  // Navigation Menu Styles
  static const unselectedText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: Sizes.small,
    height: 1.4,
    color: Colors.white60,
  );
  static const selectedText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: Sizes.small,
    height: 1.4,
    color: menuColour,
  );
  static const selectedLanguage = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: Sizes.large,
    height: 1.0,
    color: primaryColour,
    backgroundColor: foregroundColour,
  );

  static const highlightedText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: Sizes.medium,
    height: 1.0,
    color: textColour,
  );

  // Button Styles
  static final ButtonStyle appBarButton = TextButton.styleFrom(foregroundColor: foregroundColour);
  static final ButtonStyle button = TextButton.styleFrom(foregroundColor: foregroundColour);
  static const buttonTextBold = TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.medium);
  static const buttonText = TextStyle(fontWeight: FontWeight.normal, fontSize: Sizes.medium);
  static TextStyle body1 = raleway.copyWith(color: const Color(0xFF42A5F5));
  static final radioGroupBox = BoxDecoration(
    border: Border.all(color: Colors.black, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(Sizes.medium)),
  );
}

//
// Theme for the App
//

// final Color primaryColour = const Color(0xFFE31317);
const secondaryColour = Color(0xFFE3E013);

class AppTheme {
  var theme = ThemeData();
  ThemeMode themeMode = ThemeMode.dark;

  AppTheme(ThemeMode mode) {
    themeMode = mode;
    theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        // default brightness and colours
        seedColor: primaryColour,
        primary: primaryColour,
        secondary: secondaryColour,
        brightness: _getBrightness(themeMode),
      ),

      // font Family
      fontFamily: 'Arial',
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColour,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyles.h1,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        hintStyle: TextStyles.body,
        prefixIconColor: foregroundColour,
        suffixIconColor: foregroundColour,
        border: const OutlineInputBorder(
          // Border radius set to height x0.8
          borderRadius: BorderRadius.all(Radius.circular(Sizes.x2Large)),
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      dividerTheme: DividerThemeData(color: foregroundColour, thickness: 0.0),
      // iconTheme: IconThemeData(color: foregroundColour),
      // iconTheme: IconThemeData(color: Colors.green),
      // checkboxTheme: CheckboxThemeData(
      //   checkColor: WidgetStateProperty.resolveWith<Color>(
      //       (states) => Colors.transparent),
      //   fillColor:
      //       WidgetStateProperty.resolveWith<Color>((states) => Colors.white),
      // ),
    );
  }

  // Get the system brightness
  Brightness _getBrightness(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      return SchedulerBinding.instance.platformDispatcher.platformBrightness;
    }

    return themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light;
  }
}
