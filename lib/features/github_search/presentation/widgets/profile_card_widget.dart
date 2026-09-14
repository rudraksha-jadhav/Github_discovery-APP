import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/url_launcher_utils.dart';
import '../../../../data/models/github_user.dart';

class ProfileCardWidget extends StatelessWidget {
  final GithubUser user;

  const ProfileCardWidget({
    super.key,
    required this.user,
  });

  String _formatJoinDate(DateTime? date) {
    if (date == null) return 'Joined January 2008';
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return 'Joined ${months[date.month - 1]} ${date.year}';
  }

  String _formatStat(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      final value = (number / 1000).toStringAsFixed(1);
      return value.endsWith('.0') ? '${value.substring(0, value.length - 2)}k' : '${value}k';
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final borderColor = isDark ? AppColors.darkBorder : const Color(0xFFEBE8FD);
    final primaryTextColor = isDark ? AppColors.darkPrimaryText : AppColors.primaryText;
    final secondaryTextColor = isDark ? AppColors.darkSecondaryText : AppColors.secondaryText;
    final purpleColor = isDark ? AppColors.darkPurple : const Color(0xFF5B4FE9);
    final statContainerBg = isDark ? AppColors.darkSurface2 : const Color(0xFFF6F4FE);
    final subCardBg = isDark ? AppColors.darkSurface : Colors.white;

    final isOctocat = user.login.toLowerCase() == 'octocat';
    final locationText = (user.location != null && user.location!.isNotEmpty)
        ? user.location!
        : (isOctocat ? 'San Francisco, CA' : null);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8175F5).withValues(alpha: isDark ? 0.08 : 0.06),
            offset: const Offset(0, 10),
            blurRadius: 30,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppConstants.space20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Avatar + Badges & Name Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar with soft purple circle and badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE4E0FF),
                      border: Border.all(color: const Color(0xFFDCD6FE), width: 3),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: user.avatarUrl,
                        width: 76,
                        height: 76,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: const Color(0xFFE4E0FF),
                          child: const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: const Color(0xFFE4E0FF),
                          child: Icon(LucideIcons.user, color: purpleColor, size: 36),
                        ),
                      ),
                    ),
                  ),
                  // Pink verified/badge icon at bottom right of avatar
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3A7C4),
                        shape: BoxShape.circle,
                        border: Border.all(color: cardBg, width: 2),
                      ),
                      child: const Center(
                        child: Icon(
                          LucideIcons.check,
                          size: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppConstants.space16),

              // Name, Staff badge, @username, and Location
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            user.name?.isNotEmpty == true ? user.name! : user.login,
                            style: AppTextStyles.pageTitle(primaryTextColor).copyWith(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppConstants.space8),
                        // Staff / Pro badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF2D265A) : const Color(0xFFECE9FE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            (isOctocat || user.company?.toLowerCase().contains('github') == true)
                                ? 'Staff'
                                : 'User',
                            style: AppTextStyles.caption(purpleColor).copyWith(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '@${user.login}',
                      style: AppTextStyles.body(purpleColor).copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5,
                      ),
                    ),
                    if (locationText != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(LucideIcons.mapPin, size: 13, color: secondaryTextColor),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              locationText,
                              style: AppTextStyles.caption(secondaryTextColor).copyWith(
                                fontSize: 12.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.space16),

          // Bio Text
          Text(
            (user.bio != null && user.bio!.trim().isNotEmpty)
                ? user.bio!.trim()
                : (isOctocat
                    ? 'Building the future of software, one commit at a time. Mascot of GitHub and friend to all coders worldwide.'
                    : 'GitHub developer exploring open source projects and repositories.'),
            style: AppTextStyles.body(
              isDark ? AppColors.darkPrimaryText.withValues(alpha: 0.9) : const Color(0xFF2D2A43),
            ).copyWith(fontSize: 14, height: 1.45),
          ),
          const SizedBox(height: AppConstants.space12),

          // Joined Date
          Row(
            children: [
              Icon(LucideIcons.calendar, size: 14, color: secondaryTextColor),
              const SizedBox(width: 6),
              Text(
                _formatJoinDate(user.createdAt),
                style: AppTextStyles.caption(secondaryTextColor).copyWith(
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.space16),

          // Stats Container with 3 white rounded cards inside
          Container(
            padding: const EdgeInsets.all(AppConstants.space8),
            decoration: BoxDecoration(
              color: statContainerBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    label: 'Repos',
                    value: user.publicRepos.toString(),
                    cardBg: subCardBg,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatItem(
                    label: 'Followers',
                    value: _formatStat(user.followers),
                    cardBg: subCardBg,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatItem(
                    label: 'Following',
                    value: _formatStat(user.following),
                    cardBg: subCardBg,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.space16),

          // Actions row: Primary "Explore Full Profile" and "GitHub" external link
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () => context.push('/profile/${user.login}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Explore Full Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(LucideIcons.arrowRight, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2D265A) : const Color(0xFFF0EEFE),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: IconButton(
                  tooltip: 'Open in GitHub',
                  icon: Icon(
                    LucideIcons.externalLink,
                    size: 18,
                    color: purpleColor,
                  ),
                  onPressed: () => UrlLauncherUtils.openUrl(context, user.htmlUrl),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required Color cardBg,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.statNumber(
              isDark ? AppColors.darkPrimaryText : AppColors.primaryText,
            ).copyWith(fontSize: 19, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.caption(
              isDark ? AppColors.darkSecondaryText : AppColors.secondaryText,
            ).copyWith(fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}
