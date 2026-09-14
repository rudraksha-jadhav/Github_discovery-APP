import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';

class RecentSearchesWidget extends StatelessWidget {
  final List<String> recentSearches;
  final ValueChanged<String> onSelect;
  final ValueChanged<String> onRemove;
  final VoidCallback onClearAll;

  const RecentSearchesWidget({
    super.key,
    required this.recentSearches,
    required this.onSelect,
    required this.onRemove,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    if (recentSearches.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryTextColor =
        isDark ? AppColors.darkSecondaryText : AppColors.secondaryText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  LucideIcons.history,
                  size: 14,
                  color: secondaryTextColor,
                ),
                const SizedBox(width: AppConstants.space8),
                Text(
                  'Recent searches',
                  style: AppTextStyles.caption(secondaryTextColor).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: onClearAll,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(40, 24),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Clear',
                style: AppTextStyles.caption(
                  isDark ? AppColors.darkPurple : AppColors.primaryPurple,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.space8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: recentSearches.map((username) {
              return Padding(
                padding: const EdgeInsets.only(right: AppConstants.space8),
                child: InputChip(
                  label: Text(
                    username,
                    style: AppTextStyles.caption(
                      isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
                    ),
                  ),
                  avatar: Icon(
                    LucideIcons.user,
                    size: 13,
                    color: isDark ? AppColors.darkSecondaryText : AppColors.secondaryText,
                  ),
                  deleteIcon: const Icon(LucideIcons.x, size: 13),
                  deleteIconColor: secondaryTextColor,
                  onDeleted: () => onRemove(username),
                  onPressed: () => onSelect(username),
                  backgroundColor: isDark
                      ? AppColors.darkSurface
                      : AppColors.surface,
                  side: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.border,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.radiusButton),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.space8,
                    vertical: 2,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
