import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';

class SkeletonLoadingWidget extends StatefulWidget {
  const SkeletonLoadingWidget({super.key});

  @override
  State<SkeletonLoadingWidget> createState() => _SkeletonLoadingWidgetState();
}

class _SkeletonLoadingWidgetState extends State<SkeletonLoadingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? AppColors.darkSurface2 : const Color(0xFFEBE8FC);
    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.border;

    return FadeTransition(
      opacity: _animation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Status indicator text with subtle pulse
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppConstants.space12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDark ? AppColors.darkPurple : AppColors.primaryPurple,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.space8),
                  Text(
                    'Searching GitHub…',
                    style: AppTextStyles.caption(
                      isDark ? AppColors.darkPurple : AppColors.primaryPurple,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          // Skeleton Profile Card
          Container(
            padding: const EdgeInsets.all(AppConstants.space20),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
              border: Border.all(color: borderColor, width: 1.2),
            ),
            child: Column(
              children: [
                // Avatar circle
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: baseColor,
                  ),
                ),
                const SizedBox(height: AppConstants.space16),

                // Name bar
                Container(
                  width: 160,
                  height: 20,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                  ),
                ),
                const SizedBox(height: AppConstants.space8),

                // Username bar
                Container(
                  width: 100,
                  height: 14,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                  ),
                ),
                const SizedBox(height: AppConstants.space16),

                // Bio bar
                Container(
                  width: double.infinity,
                  height: 14,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                  ),
                ),
                const SizedBox(height: AppConstants.space20),

                // Stats row
                Row(
                  children: List.generate(
                    3,
                    (index) => Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: index == 1 ? AppConstants.space8 : 0,
                        ),
                        height: 58,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppConstants.space24),

          // Skeleton Repositories Title
          Container(
            width: 140,
            height: 18,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
            ),
          ),
          const SizedBox(height: AppConstants.space12),

          // Skeleton Repositories Cards
          ...List.generate(
            3,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: AppConstants.space12),
              padding: const EdgeInsets.all(AppConstants.space16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(AppConstants.radiusCard),
                border: Border.all(color: borderColor, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140 + (index * 30.0),
                    height: 16,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                    ),
                  ),
                  const SizedBox(height: AppConstants.space8),
                  Container(
                    width: double.infinity,
                    height: 12,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                    ),
                  ),
                  const SizedBox(height: AppConstants.space12),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 12,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                      ),
                      const SizedBox(width: AppConstants.space16),
                      Container(
                        width: 40,
                        height: 12,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
