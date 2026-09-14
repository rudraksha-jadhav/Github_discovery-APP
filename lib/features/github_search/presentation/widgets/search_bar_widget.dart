import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;
  final bool isLoading;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.isLoading,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _hasText = widget.controller.text.trim().isNotEmpty;
    widget.controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    final hasNow = widget.controller.text.trim().isNotEmpty;
    if (hasNow != _hasText) {
      setState(() {
        _hasText = hasNow;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    super.dispose();
  }

  void _submitSearch() {
    if (widget.isLoading) return;
    final query = widget.controller.text.trim();
    if (query.isNotEmpty) {
      widget.onSearch(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final borderColor = isDark ? AppColors.darkBorder : const Color(0xFFEBE8FD);
    final inputBg = isDark ? const Color(0xFF1E1B38) : const Color(0xFFF5F3FF);
    final purpleColor = isDark ? AppColors.darkPurple : const Color(0xFF5B4FE9);

    return Container(
      padding: const EdgeInsets.all(AppConstants.space16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8175F5).withValues(alpha: isDark ? 0.08 : 0.05),
            offset: const Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search Input Field
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: inputBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: widget.controller,
              textInputAction: TextInputAction.search,
              autocorrect: false,
              style: AppTextStyles.input(
                isDark ? AppColors.darkPrimaryText : const Color(0xFF17152B),
              ).copyWith(fontSize: 15, fontWeight: FontWeight.w500),
              cursorColor: purpleColor,
              onSubmitted: (_) => _submitSearch(),
              decoration: InputDecoration(
                hintText: 'Enter GitHub username (e.g. torvalds)...',
                hintStyle: AppTextStyles.body(
                  isDark ? AppColors.darkSecondaryText : const Color(0xFF8A879E),
                ).copyWith(fontSize: 14),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: Icon(
                  LucideIcons.search,
                  size: 19,
                  color: purpleColor,
                ),
                suffixIcon: _hasText
                    ? IconButton(
                        icon: const Icon(LucideIcons.x, size: 16),
                        color: isDark ? AppColors.darkSecondaryText : const Color(0xFF77748A),
                        splashRadius: 16,
                        tooltip: 'Clear username',
                        onPressed: () {
                          widget.controller.clear();
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Search Profile Button with InkWell and gradient
          Material(
            color: Colors.transparent,
            child: Ink(
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF5B4FE9),
                    Color(0xFFF3A7C4),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5B4FE9).withValues(alpha: 0.28),
                    offset: const Offset(0, 6),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: widget.isLoading ? null : _submitSearch,
                child: Center(
                  child: widget.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Search Profile',
                              style: AppTextStyles.button(Colors.white).copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              LucideIcons.arrowRight,
                              color: Colors.white,
                              size: 17,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
