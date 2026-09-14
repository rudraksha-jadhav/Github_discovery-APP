import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized Typography using Plus Jakarta Sans.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle pageTitle([Color color = AppColors.primaryText]) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -0.5,
        height: 1.2,
      );

  static TextStyle subtitle([Color color = AppColors.secondaryText]) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.4,
      );

  static TextStyle sectionTitle([Color color = AppColors.primaryText]) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: -0.3,
      );

  static TextStyle body([Color color = AppColors.primaryText]) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.5,
      );

  static TextStyle bodyMedium([Color color = AppColors.primaryText]) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle statNumber([Color color = AppColors.primaryText]) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: -0.5,
      );

  static TextStyle caption([Color color = AppColors.secondaryText]) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle button([Color color = Colors.white]) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.2,
      );

  static TextStyle input([Color color = AppColors.primaryText]) =>
      GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: color,
      );
}
