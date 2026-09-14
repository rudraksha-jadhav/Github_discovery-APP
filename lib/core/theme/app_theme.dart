import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../constants/app_text_styles.dart';

class DarkModeNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void setMode(bool isDark) => state = isDark;
}

final isDarkModeProvider =
    NotifierProvider<DarkModeNotifier, bool>(DarkModeNotifier.new);

/// Centralized ThemeData supporting Light and Dark modes.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryPurple,
        secondary: AppColors.pinkAccent,
        surface: AppColors.surface,
        error: AppColors.errorText,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.primaryText,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTextStyles.sectionTitle(AppColors.primaryText),
        iconTheme: const IconThemeData(color: AppColors.primaryText),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.space20,
          vertical: AppConstants.space16,
        ),
        hintStyle: AppTextStyles.body(AppColors.secondaryText),
        prefixIconColor: AppColors.secondaryText,
        suffixIconColor: AppColors.secondaryText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          borderSide: const BorderSide(color: AppColors.primaryPurple, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          borderSide: const BorderSide(color: AppColors.errorText, width: 1),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPurple,
        secondary: AppColors.darkPink,
        surface: AppColors.darkSurface,
        error: AppColors.darkError,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkPrimaryText,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTextStyles.sectionTitle(AppColors.darkPrimaryText),
        iconTheme: const IconThemeData(color: AppColors.darkPrimaryText),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.space20,
          vertical: AppConstants.space16,
        ),
        hintStyle: AppTextStyles.body(AppColors.darkSecondaryText),
        prefixIconColor: AppColors.darkSecondaryText,
        suffixIconColor: AppColors.darkSecondaryText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          borderSide: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          borderSide: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          borderSide: const BorderSide(color: AppColors.darkPurple, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          borderSide: const BorderSide(color: AppColors.darkError, width: 1),
        ),
      ),
    );
  }
}
