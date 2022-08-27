import 'package:flutter/material.dart';

enum ScreenSize {
  xs,
  sm,
  md,
  lg,
  xl,
  xxl;

  bool get isLarge =>
      this == ScreenSize.lg || this == ScreenSize.xl || this == ScreenSize.xxl;

  double get breakpoint {
    switch (this) {
      case ScreenSize.xs:
        return 576;
      case ScreenSize.sm:
        return 576;
      case ScreenSize.md:
        return 768;
      case ScreenSize.lg:
        return 992;
      case ScreenSize.xl:
        return 1200;
      case ScreenSize.xxl:
        return 1400;
    }
  }

  static ScreenSize of(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= ScreenSize.sm.breakpoint) {
      return ScreenSize.xs;
    } else if (screenWidth <= ScreenSize.md.breakpoint) {
      return ScreenSize.sm;
    } else if (screenWidth <= ScreenSize.lg.breakpoint) {
      return ScreenSize.md;
    } else if (screenWidth <= ScreenSize.xl.breakpoint) {
      return ScreenSize.lg;
    } else if (screenWidth <= ScreenSize.xxl.breakpoint) {
      return ScreenSize.xl;
    } else {
      return ScreenSize.xxl;
    }
  }

  static int gridCrossAxisCount(BuildContext context) {
    switch (ScreenSize.of(context)) {
      case ScreenSize.xs:
      case ScreenSize.sm:
        return 1;
      case ScreenSize.md:
        return 2;
      case ScreenSize.lg:
        return 3;
      case ScreenSize.xl:
        return 4;
      case ScreenSize.xxl:
        return 5;
    }
  }
}
