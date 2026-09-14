import 'package:flutter/material.dart';

/// Centralized layout, spacing, and application constants.
class AppConstants {
  AppConstants._();

  // Spacing (4/8 system)
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space28 = 28.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;

  // Radii
  static const double radiusSmall = 8.0;
  static const double radiusCard = 16.0;
  static const double radiusLarge = 20.0;
  static const double radiusButton = 16.0;

  // Touch targets
  static const double buttonHeight = 54.0;
  static const double searchBarHeight = 56.0;

  // GitHub API Limits & Configs
  static const int repoLimit = 10;
  static const String githubApiBaseUrl = 'https://api.github.com';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  // Storage Keys
  static const String recentSearchesKey = 'recent_github_searches';
  static const int maxRecentSearches = 5;

  // Shadows
  static List<BoxShadow> softShadow([Color? shadowColor]) => [
        BoxShadow(
          color: shadowColor ?? const Color(0x0C8175F5),
          offset: const Offset(0, 8),
          blurRadius: 24,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: shadowColor ?? const Color(0x0617152B),
          offset: const Offset(0, 2),
          blurRadius: 6,
          spreadRadius: 0,
        ),
      ];
}
