import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/network/api_exception.dart';

class ErrorStateWidget extends StatelessWidget {
  final ApiException exception;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    super.key,
    required this.exception,
    required this.onRetry,
  });

  IconData _getIcon() {
    if (exception is ApiUserNotFoundException) {
      return LucideIcons.userX;
    } else if (exception is ApiRateLimitException) {
      return LucideIcons.clock;
    } else if (exception is ApiTimeoutException) {
      return LucideIcons.timerOff;
    } else if (exception is ApiNetworkException) {
      return LucideIcons.wifiOff;
    } else if (exception is EmptyUsernameException) {
      return LucideIcons.alertCircle;
    }
    return LucideIcons.alertTriangle;
  }

  String _getButtonLabel() {
    if (exception is ApiUserNotFoundException || exception is EmptyUsernameException) {
      return 'Try Again';
    }
    return 'Retry';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.darkPrimaryText : AppColors.primaryText;
    final secondaryTextColor =
        isDark ? AppColors.darkSecondaryText : AppColors.secondaryText;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.border;

    final isRateLimit = exception is ApiRateLimitException;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.space24,
        vertical: AppConstants.space32,
      ),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: AppConstants.softShadow(
          isDark ? Colors.black26 : null,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Soft icon badge with pastel error tone
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark
                  ? AppColors.darkError.withValues(alpha: 0.15)
                  : const Color(0xFFFFECEC),
              border: Border.all(
                color: isDark ? AppColors.darkError : AppColors.error,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Icon(
                _getIcon(),
                size: 32,
                color: isDark ? AppColors.darkError : const Color(0xFFE53935),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.space20),

          // Title
          Text(
            exception.title,
            style: AppTextStyles.sectionTitle(primaryTextColor).copyWith(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.space8),

          // User-friendly message
          Text(
            exception.message,
            style: AppTextStyles.body(secondaryTextColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.space24),

          // Action button
          if (!isRateLimit)
            SizedBox(
              height: 46,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(LucideIcons.refreshCw, size: 16),
                label: Text(
                  _getButtonLabel(),
                  style: AppTextStyles.button(Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark ? AppColors.darkPurple : AppColors.primaryPurple,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.space24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.radiusButton),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
