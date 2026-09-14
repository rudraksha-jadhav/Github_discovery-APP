import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme.dart';
import 'features/github_search/providers/github_providers.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientation to portrait for optimal mobile-first UX
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Pre-initialize SharedPreferences
  SharedPreferences? prefs;
  try {
    prefs = await SharedPreferences.getInstance();
  } catch (_) {
    // Continue with null if not accessible
  }

  runApp(
    ProviderScope(
      overrides: [
        if (prefs != null) sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const GithubExplorerApp(),
    ),
  );
}

class GithubExplorerApp extends ConsumerWidget {
  const GithubExplorerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'GitHub Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
    );
  }
}
