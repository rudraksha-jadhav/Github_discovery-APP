import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../data/models/github_repository.dart';

class RepositoryCardWidget extends StatelessWidget {
  final GithubRepository repository;
  final int index;

  const RepositoryCardWidget({
    super.key,
    required this.repository,
    this.index = 0,
  });

  String _formatCount(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      final value = (number / 1000).toStringAsFixed(1);
      return value.endsWith('.0') ? '${value.substring(0, value.length - 2)}k' : '${value}k';
    }
    return number.toString();
  }

  Color _getLanguageColor(String? language) {
    switch (language?.toLowerCase()) {
      case 'html':
        return const Color(0xFF9E6A56);
      case 'typescript':
        return const Color(0xFF5B4FE9);
      case 'javascript':
        return const Color(0xFF8B3A4F);
      case 'dart':
        return const Color(0xFF00B4AB);
      case 'python':
        return const Color(0xFF3572A5);
      case 'java':
        return const Color(0xFFB07219);
      case 'kotlin':
        return const Color(0xFFA97BFF);
      case 'swift':
        return const Color(0xFFF05138);
      default:
        return const Color(0xFF5B4FE9);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final borderColor = isDark ? AppColors.darkBorder : const Color(0xFFEBE8FD);
    final secondaryTextColor = isDark ? AppColors.darkSecondaryText : const Color(0xFF5A5872);
    final purpleColor = isDark ? AppColors.darkPurple : const Color(0xFF4F46E5);

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.space12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8175F5).withValues(alpha: isDark ? 0.08 : 0.04),
            offset: const Offset(0, 4),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            final owner = repository.fullName.contains('/')
                ? repository.fullName.split('/').first
                : '';
            if (owner.isNotEmpty) {
              context.push('/repo/$owner/${repository.name}');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Book icon + Repo Name + Spacer + "Public" pill
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.bookMarked,
                      size: 16,
                      color: purpleColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        repository.name,
                        style: AppTextStyles.bodyMedium(purpleColor).copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface2 : const Color(0xFFF1EFFE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Public',
                        style: AppTextStyles.caption(
                          isDark ? AppColors.darkSecondaryText : const Color(0xFF5B5775),
                        ).copyWith(fontSize: 11, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),

                // Description
                if (repository.description != null && repository.description!.trim().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    repository.description!.trim(),
                    style: AppTextStyles.body(secondaryTextColor).copyWith(
                      fontSize: 13,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                const SizedBox(height: 14),

                // Bottom row: Language + Stars + Forks + ArrowUpRight
                Row(
                  children: [
                    // Language with circle
                    if (repository.language != null && repository.language!.isNotEmpty) ...[
                      Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          color: _getLanguageColor(repository.language),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        repository.language!,
                        style: AppTextStyles.caption(
                          isDark ? AppColors.darkPrimaryText : const Color(0xFF374151),
                        ).copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 14),
                    ],

                    // Stars
                    Row(
                      children: [
                        Icon(
                          LucideIcons.star,
                          size: 13,
                          color: secondaryTextColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatCount(repository.stargazersCount),
                          style: AppTextStyles.caption(secondaryTextColor).copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),

                    // Forks
                    Row(
                      children: [
                        Icon(
                          LucideIcons.gitFork,
                          size: 13,
                          color: secondaryTextColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatCount(repository.forksCount),
                          style: AppTextStyles.caption(secondaryTextColor).copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Arrow Up Right
                    Icon(
                      LucideIcons.arrowUpRight,
                      size: 16,
                      color: purpleColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
