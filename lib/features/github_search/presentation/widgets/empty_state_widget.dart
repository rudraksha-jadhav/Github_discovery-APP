import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  final ValueChanged<String> onSelectSuggestion;

  const EmptyStateWidget({
    super.key,
    required this.onSelectSuggestion,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.darkPrimaryText : AppColors.primaryText;
    final secondaryTextColor =
        isDark ? AppColors.darkSecondaryText : AppColors.secondaryText;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.border;

    const suggestions = ['octocat', 'torvalds', 'flutter', 'dart-lang'];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.space24,
        vertical: AppConstants.space32,
      ),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: AppConstants.softShadow(
          isDark ? Colors.black26 : null,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Soft decorative icon container
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? AppColors.darkSurface2 : const Color(0xFFF3F1FD),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightPurple,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Icon(
                LucideIcons.github,
                size: 38,
                color: isDark ? AppColors.darkPurple : AppColors.primaryPurple,
              ),
            ),
          ),
          const SizedBox(height: AppConstants.space20),

          // Heading
          Text(
            'Find a developer',
            style: AppTextStyles.sectionTitle(primaryTextColor).copyWith(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.space8),

          // Description
          Text(
            'Enter a GitHub username above to explore their profile and public repositories.',
            style: AppTextStyles.body(secondaryTextColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.space24),

          // Suggestion prompt & chips
          Text(
            'Try one of these:',
            style: AppTextStyles.caption(secondaryTextColor).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.space12),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppConstants.space8,
            runSpacing: AppConstants.space8,
            children: suggestions.map((name) {
              return ActionChip(
                label: Text(
                  '@$name',
                  style: AppTextStyles.caption(
                    isDark ? AppColors.darkPurple : AppColors.primaryPurple,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                backgroundColor: isDark
                    ? AppColors.darkSurface2
                    : const Color(0xFFF1EFFE),
                side: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightPurple,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusButton),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.space8,
                  vertical: AppConstants.space4,
                ),
                onPressed: () => onSelectSuggestion(name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
