# 🌟 GitHub Discovery App

[![Flutter](https://img.shields.io/badge/Flutter-3.32+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.8+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/State-Riverpod_3.3-blueviolet?style=for-the-badge)](https://riverpod.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-lightgrey?style=for-the-badge)](https://flutter.dev)

A modern, developer-oriented mobile and multi-platform application built with Flutter to search, explore, and bookmark GitHub developers and open-source repositories. Crafted with the **Soft Aurora** design language, offering a fluid, responsive, and aesthetically pleasing developer experience.

---

## 📸 Key Features & Capabilities

### 🔍 1. Developer & Repository Search
- **Instant Search**: Look up any public GitHub profile by username with keyboard support and debounce.
- **Recent Search History**: Locally cached recent searches (`shared_preferences`) with one-tap re-querying and quick deletion.
- **Live User Card**: Immediate display of developer avatar, full name, username, bio, company, location, and key metrics (public repos, followers, following).

### 🧭 2. Discover & Trending Hub
- **Featured Developers**: Quick access to prominent open-source creators and industry icons (e.g., Linus Torvalds, Dan Abramov, Mitchell Hashimoto, Anthony Fu).
- **Curated Topics & Stacks**: Explore top repositories across multiple technologies (Flutter, Rust, TypeScript, Python, Go, and AI/ML).
- **One-Tap Exploration**: Jump directly into profiles and repositories with a single tap.

### 👤 3. In-Depth Developer Profile View
- **Multi-Tab Layout**:
  - **Repositories Tab**: Browse all public repos with real-time search, language chip filters, and sorting (by Stars, Recently Updated, or Forks).
  - **Activity Tab**: Real-time event stream of recent public actions (Push, Star, Fork, Issue events).
  - **About Tab**: Complete biographical summary, social links, blog/portfolio, and join date.
- **Direct Navigation**: Tap any repository from a user's profile to open the repository detail screen.

### 📦 4. Comprehensive Repository Viewer
- **In-App README Rendering**: Full-featured Markdown rendering (`flutter_markdown`) with custom syntax styling and headers.
- **Repository Metadata**: Real-time star counts, forks, watchers, open issues, license badge, default branch, and topic tags.
- **External Web Launcher**: Easily open the repository or author's GitHub page in your default browser (`url_launcher`).

### 🔖 5. Local Bookmarks & Saved Items
- **Save Anything**: Bookmark developers and repositories directly from their profile or detail pages.
- **Filter Tabs**: Separate views for saved **Developers** and saved **Repositories**.
- **Offline Persistence**: Bookmarks are stored persistently on the device for fast access anytime.

### 🎨 6. Soft Aurora Design System & Dark Mode
- **Dual Theme Support**: Flawless switching between an elegant Light theme and a sleek GitHub-inspired Dark mode (`#0D1117`).
- **Aurora Color Palette**: Custom primary purples (`#8175F5`), lavender surfaces, mint highlights, and subtle border gradients.
- **Smooth Navigation**: Persistent bottom navigation bar powered by `go_router` StatefulShellRoute for seamless tab state preservation.
- **Skeleton Shimmer Loaders**: Premium shimmer skeleton states during network requests instead of generic spinners.

### ⚡ 7. Resilient Network & Error Handling
- **Rate Limit Detection (HTTP 403)**: Catches unauthenticated rate limits with friendly waiting notifications and rate-limit reset timers.
- **Live API Quota Monitor**: View your remaining hourly GitHub API quota directly from the Settings screen.
- **Graceful Error States**: Specific error handling for 404 User Not Found, connection timeouts, and offline networks with retry triggers.

---

## 🛠️ Tech Stack & Architecture

- **UI Framework**: [Flutter](https://flutter.dev) (Dart 3.8+)
- **State Management**: [Riverpod (`flutter_riverpod`)](https://riverpod.dev) with `Notifier`, `AsyncNotifier`, and `ProviderScope`
- **Routing**: [GoRouter (`go_router`)](https://pub.dev/packages/go_router) with `StatefulShellRoute` for indexed bottom navigation
- **HTTP Client**: [Dio](https://pub.dev/packages/dio) with custom headers, interceptors, and timeout configs
- **Markdown Viewer**: [flutter_markdown](https://pub.dev/packages/flutter_markdown)
- **Image Caching**: [cached_network_image](https://pub.dev/packages/cached_network_image)
- **Icons**: [Lucide Icons (`lucide_icons`)](https://lucide.dev)
- **Typography**: [Google Fonts (`google_fonts`) - Plus Jakarta Sans](https://fonts.google.com/specimen/Plus+Jakarta+Sans)
- **Data Serialization**: [Freezed](https://pub.dev/packages/freezed) & [json_serializable](https://pub.dev/packages/json_serializable)
- **Local Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences)

### Architecture Overview

The app follows a modular **MVVM + Clean Repository Pattern**:

```text
lib/
├── core/
│   ├── constants/            # AppColors, AppTextStyles, AppConstants
│   ├── network/              # DioClient, ApiException handling
│   ├── theme/                # AppTheme (Light & Dark Themes)
│   └── utils/                # UrlLauncherUtils, formatters
├── data/
│   ├── models/               # GithubUser, GithubRepository, BookmarkItem, Activity
│   ├── services/             # GithubApiService (Dio REST implementation)
│   └── repositories/         # GithubSearchRepository, BookmarksRepository
├── features/
│   ├── github_search/        # Search screen, SearchViewModel, UI widgets & states
│   ├── explore/              # Trending & featured developers explore screen
│   ├── profile/              # Developer details screen, activity feed, tab view
│   ├── repository/           # Repository details & Markdown README screen
│   ├── bookmarks/            # Saved items screen & tabbed lists
│   └── settings/             # Theme switcher, API quota monitor, cache clear
├── router/
│   └── app_router.dart       # GoRouter StatefulShellRoute configuration
└── main.dart                 # Application entrypoint & ProviderScope setup
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.32.0`)
- [Dart SDK](https://dart.dev/get-dart) (`>= 3.8.0`)
- Android Studio / Xcode / VS Code with Flutter extension

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/rudraksha-jadhav/Github_discovery-APP.git
   cd Github_discovery-APP
   ```

2. **Install project dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run code generation** *(optional, only if modifying Freezed/JSON models)*:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

---

## 🧪 Testing & Analysis

Run static analysis and unit/widget test suites:

```bash
# Check code style & lints
flutter analyze

# Run unit and widget tests
flutter test
```

---

## 🌐 GitHub REST API Usage & Rate Limits

This application connects to GitHub's public REST API v3:
- **User Profile**: `GET https://api.github.com/users/{username}`
- **User Repositories**: `GET https://api.github.com/users/{username}/repos`
- **User Activity**: `GET https://api.github.com/users/{username}/events/public`
- **Repository Details**: `GET https://api.github.com/repos/{owner}/{repo}`
- **Repository README**: `GET https://api.github.com/repos/{owner}/{repo}/readme`
- **Rate Limit Status**: `GET https://api.github.com/rate_limit`

> **Note**: GitHub provides 60 unauthenticated requests per hour per IP. The app includes built-in rate-limit monitoring under **Settings > GitHub API Rate Limit**.

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
