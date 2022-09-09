import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff7AC5C1);
  static const Color primaryLighter = Color(0xffE6F9FF);
  static const Color white = Color(0xffffffff);
  static const Color realBlack = Color(0xff000000);
  static const Color text = Color(0xff0F1E31);
  static const Color black = Color(0xff0F1E31);
  static const Color blackLight = Color(0xff1B2C41);
  static const Color orangeDark = Color(0xffCE5A01);
  static const Color yellow = Color(0xffFFEF7D);
  static const Color sugar = Color(0xffFBF5E9);
  static const Color honey = Color(0xffDA7C16);
  static const Color pinkLight = Color(0xffF9B7B6);
  static const Color green = Color(0xffADBE56);
  static const Color red = Color(0xffCF252F);

  static MaterialColor primaryMaterialColor =
      getMaterialColorFromColor(AppColors.primary);

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color, //Primary value
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }

  static Color textColorFromBackground(Color background) =>
      background.computeLuminance() > 0.3 ? Colors.black : Colors.white;

  static Brightness getBrightness(Color color) {
    final double relativeLuminance = color.computeLuminance();
    const double kThreshold = 0.15;
    return ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) >
            kThreshold)
        ? Brightness.light
        : Brightness.dark;
  }
}
