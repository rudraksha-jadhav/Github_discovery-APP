import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bookmark_item.dart';

const String _bookmarksKey = 'github_explorer_bookmarks_v1';

class BookmarksRepository {
  final SharedPreferences? _prefs;

  BookmarksRepository({SharedPreferences? prefs}) : _prefs = prefs;

  Future<List<BookmarkItem>> getBookmarks() async {
    try {
      final prefs = _prefs ?? await SharedPreferences.getInstance();
      final stringList = prefs.getStringList(_bookmarksKey) ?? [];
      return stringList.map((s) => BookmarkItem.fromJson(s)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveBookmarks(List<BookmarkItem> items) async {
    try {
      final prefs = _prefs ?? await SharedPreferences.getInstance();
      final stringList = items.map((i) => i.toJson()).toList();
      await prefs.setStringList(_bookmarksKey, stringList);
    } catch (_) {
      // Storage error
    }
  }
}

class BookmarksNotifier extends Notifier<List<BookmarkItem>> {
  late final BookmarksRepository _repository;

  @override
  List<BookmarkItem> build() {
    _repository = BookmarksRepository(prefs: null);
    _loadInitialBookmarks();
    return [];
  }

  Future<void> _loadInitialBookmarks() async {
    final list = await _repository.getBookmarks();
    state = list;
  }

  bool isBookmarked(String id, BookmarkType type) {
    return state.any((item) => item.id == id && item.type == type);
  }

  Future<void> toggleBookmark(BookmarkItem item) async {
    if (isBookmarked(item.id, item.type)) {
      await removeBookmark(item.id, item.type);
    } else {
      await addBookmark(item);
    }
  }

  Future<void> addBookmark(BookmarkItem item) async {
    final updated = [
      item,
      ...state.where((i) => !(i.id == item.id && i.type == item.type)),
    ];
    state = updated;
    await _repository.saveBookmarks(updated);
  }

  Future<void> removeBookmark(String id, BookmarkType type) async {
    final updated = state.where((i) => !(i.id == id && i.type == type)).toList();
    state = updated;
    await _repository.saveBookmarks(updated);
  }

  Future<void> clearAll() async {
    state = [];
    await _repository.saveBookmarks([]);
  }
}

final bookmarksProvider =
    NotifierProvider<BookmarksNotifier, List<BookmarkItem>>(BookmarksNotifier.new);
