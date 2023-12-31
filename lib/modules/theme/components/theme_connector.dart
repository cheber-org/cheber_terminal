import 'package:oshmes_terminal/core/widgets/controller_connector.dart';
import 'package:oshmes_terminal/core/widgets/rx_builder.dart';
import 'package:oshmes_terminal/modules/theme/controllers/theme.controller.dart';
import 'package:oshmes_terminal/modules/theme/models/theme.dart';
import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  final OshmesAppTheme theme;

  const AppTheme({
    required this.theme,
    required Widget child,
    super.key,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static Color colorWithLightness(Color color, double lightness) {
    var hslColor = HSLColor.fromColor(color);

    return hslColor.withLightness(hslColor.lightness + lightness).toColor();
  }

  static OshmesAppTheme of(BuildContext context) {
    var appTheme = context.dependOnInheritedWidgetOfExactType<AppTheme>();

    return appTheme!.theme;
  }
}

class ThemeConnector extends StatefulWidget {
  const ThemeConnector({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  State<ThemeConnector> createState() => _ThemeConnectorState();
}

class _ThemeConnectorState extends State<ThemeConnector> {
  @override
  Widget build(BuildContext context) {
    return ControllerConnector<ThemeController>(
      builder: (context, controller) => RxStateBuilder(
        state: controller.theme$,
        builder: (context, theme) => AppTheme(
          theme: theme!,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme.toMaterialLightTheme(),
            darkTheme: theme.toMaterialDarkTheme(),
            home: widget.child,
          ),
        ),
      ),
    );
  }
}
