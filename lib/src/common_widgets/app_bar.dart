import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:campervan/src/constants/app_sizes.dart';
import 'package:campervan/src/constants/theme_provider.dart';
import 'package:campervan/src/routing/app_router.dart';
import 'package:campervan/src/constants/theme.dart';

class AppBarWidget extends ConsumerStatefulWidget {
  const AppBarWidget({super.key, required this.title, this.hasSubTitle = false});
  final String title;
  final bool hasSubTitle;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends ConsumerState<AppBarWidget> {
  IconData iconData = Icons.sunny;

  @override
  void initState() {
    super.initState();

    final themeMode = ref.read(themeProvider).themeMode;
    final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    switch (themeMode) {
      case ThemeMode.system:
        iconData = isDarkMode ? Icons.light_mode : Icons.dark_mode;
        break;
      case ThemeMode.light:
        iconData = Icons.light_mode;
        break;
      case ThemeMode.dark:
        iconData = Icons.dark_mode;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.title.isNotEmpty);

    final themeMode = ref.watch(themeProvider).themeMode;

    final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    void toggleIcon() {
      setState(() {
        switch (themeMode) {
          case ThemeMode.system:
            iconData = isDarkMode ? Icons.light_mode : Icons.dark_mode;
            break;
          case ThemeMode.light:
            iconData = Icons.dark_mode;
            break;
          case ThemeMode.dark:
            iconData = Icons.light_mode;
            break;
        }
      });
    }

    toggleIcon();

    return AppBar(
      title: Text('CamperVan Dashboard'),
      actions: <Widget>[
        AppBarButton(title: 'Home', icon: Icons.home, route: AppRoute.home.name),
        AppBarButton(title: 'Settings', icon: FontAwesomeIcons.gear, route: AppRoute.settings.name),
        //TODO wrap with constant sized box with rounded borders
        IconButton(
          icon: Icon(iconData, size: Sizes.xLarge),
          onPressed: () {
            ref.read(themeProvider.notifier).toggleTheme();
            toggleIcon();
          },
        ),
      ],
    );
  }
}

class AppBarButton extends StatelessWidget {
  const AppBarButton({required this.title, required this.icon, required this.route, super.key});

  final String title;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        context.goNamed(route);
      },
      style: TextStyles.appBarButton,
      icon: Icon(icon, color: Colors.white, size: Sizes.large),
      label: Text(title),
    );
  }
}
