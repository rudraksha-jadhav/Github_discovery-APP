import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/constants/app_colors.dart';
import '../features/bookmarks/presentation/screens/bookmarks_screen.dart';
import '../features/explore/presentation/screens/explore_screen.dart';
import '../features/github_search/presentation/screens/github_search_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/repository/presentation/screens/repository_details_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // 0: Search
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const GithubSearchScreen(),
              ),
            ],
          ),
          // 1: Discover
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          // 2: Bookmarks
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bookmarks',
                builder: (context, state) => const BookmarksScreen(),
              ),
            ],
          ),
          // 3: Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      // Sub-routes pushed on root navigator
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/profile/:username',
        builder: (context, state) {
          final username = state.pathParameters['username'] ?? '';
          return ProfileScreen(username: username);
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/repo/:owner/:repo',
        builder: (context, state) {
          final owner = state.pathParameters['owner'] ?? '';
          final repo = state.pathParameters['repo'] ?? '';
          return RepositoryDetailsScreen(owner: owner, repo: repo);
        },
      ),
    ],
  );
});

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          backgroundColor: Colors.transparent,
          indicatorColor: AppColors.primary.withValues(alpha: 0.16),
          elevation: 0,
          destinations: const [
            NavigationDestination(
              icon: Icon(LucideIcons.search, size: 20),
              selectedIcon: Icon(LucideIcons.search, size: 20, color: AppColors.primaryPurple),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.compass, size: 20),
              selectedIcon: Icon(LucideIcons.compass, size: 20, color: AppColors.primaryPurple),
              label: 'Discover',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.bookmark, size: 20),
              selectedIcon: Icon(LucideIcons.bookmark, size: 20, color: AppColors.primaryPurple),
              label: 'Bookmarks',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.settings, size: 20),
              selectedIcon: Icon(LucideIcons.settings, size: 20, color: AppColors.primaryPurple),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
