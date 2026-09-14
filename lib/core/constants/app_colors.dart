import 'package:flutter/material.dart';

/// Centralized color system for GitHub Explorer.
/// Adheres strictly to the Soft Aurora / Modern Developer Utility design specification.
class AppColors {
  AppColors._();

  // Light Theme Palette
  static const Color background = Color(0xFFF7F6FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primaryPurple = Color(0xFF8175F5);
  static const Color lightPurple = Color(0xFFE4E0FF);
  static const Color pinkAccent = Color(0xFFF3A7C4);
  static const Color peachAccent = Color(0xFFFFD7CC);
  static const Color mintSuccess = Color(0xFFC5F2D1);
  static const Color primaryText = Color(0xFF17152B);
  static const Color secondaryText = Color(0xFF77748A);
  static const Color githubBlack = Color(0xFF1F2328);
  static const Color error = Color(0xFFFFB6B6);
  static const Color errorText = Color(0xFFD32F2F);
  static const Color border = Color(0xFFECE9FC);

  // Modern Convenience Aliases
  static const Color primary = primaryPurple;
  static const Color secondary = pinkAccent;
  static const Color accentMint = mintSuccess;
  static const Color success = Color(0xFF2EA043);
  static const Color lightBackground = background;
  static const Color lightSurface = surface;
  static const Color lightSurfaceElevated = Color(0xFFF6F4FE);
  static const Color lightBorder = border;
  static const Color lightTextPrimary = primaryText;
  static const Color lightTextSecondary = secondaryText;

  // Dark Theme Palette
  static const Color darkBackground = Color(0xFF0D1117);
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkSurface2 = Color(0xFF21262D);
  static const Color darkSurfaceElevated = Color(0xFF21262D);
  static const Color darkPrimaryText = Color(0xFFF0F6FC);
  static const Color darkSecondaryText = Color(0xFF8B949E);
  static const Color darkTextPrimary = darkPrimaryText;
  static const Color darkTextSecondary = darkSecondaryText;
  static const Color darkPurple = Color(0xFFA78BFA);
  static const Color darkPink = Color(0xFFF0A6C8);
  static const Color darkSuccess = Color(0xFF3FB950);
  static const Color darkError = Color(0xFFF85149);
  static const Color darkBorder = Color(0xFF30363D);

  // Gradient definitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, pinkAccent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient softAuroraGradient = LinearGradient(
    colors: [Color(0xFFEDE9FE), Color(0xFFFCE7F3), Color(0xFFF7F6FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkPrimaryGradient = LinearGradient(
    colors: [darkPurple, darkPink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
