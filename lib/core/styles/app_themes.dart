import 'package:flutter/material.dart';
import 'package:recipes_ui/core/styles/app_colors.dart';
import 'package:recipes_ui/core/styles/app_text_styles.dart';

class AppThemes {
  static ThemeData main({bool isDark = false}) {
    return ThemeData(
      primaryColor: AppColors.primary,
      primarySwatch: AppColors.primaryMaterialColor,
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: AppTextStyles.fontFamily,
      scaffoldBackgroundColor: isDark ? AppColors.black : AppColors.sugar,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColors.black : AppColors.sugar,
        elevation: 0,
      ),
      shadowColor: isDark
          ? AppColors.realBlack.withOpacity(0.4)
          : AppColors.black.withOpacity(0.2),
      cardColor: isDark ? AppColors.blackLight : AppColors.white,
      textTheme: TextTheme(
        headline1: AppTextStyles.h1.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        headline2: AppTextStyles.h2.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        headline3: AppTextStyles.h3.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        headline4: AppTextStyles.h4.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        headline5: AppTextStyles.h5.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        bodyText1: AppTextStyles.bodyLg.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        bodyText2: AppTextStyles.body.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
        subtitle1: AppTextStyles.bodySm.copyWith(
          color: isDark ? AppColors.white : AppColors.black,
        ),
      ),
    );
  }
}
