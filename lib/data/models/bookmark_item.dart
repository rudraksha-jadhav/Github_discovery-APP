import 'dart:convert';

enum BookmarkType { user, repository }

class BookmarkItem {
  final String id;
  final BookmarkType type;
  final String title;
  final String subtitle;
  final String? avatarUrl;
  final String? extra; // e.g. language or follower count
  final String url;
  final DateTime savedAt;

  const BookmarkItem({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    this.avatarUrl,
    this.extra,
    required this.url,
    required this.savedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'subtitle': subtitle,
      'avatarUrl': avatarUrl,
      'extra': extra,
      'url': url,
      'savedAt': savedAt.toIso8601String(),
    };
  }

  factory BookmarkItem.fromMap(Map<String, dynamic> map) {
    return BookmarkItem(
      id: map['id'] as String? ?? '',
      type: (map['type'] as String?) == 'repository'
          ? BookmarkType.repository
          : BookmarkType.user,
      title: map['title'] as String? ?? '',
      subtitle: map['subtitle'] as String? ?? '',
      avatarUrl: map['avatarUrl'] as String?,
      extra: map['extra'] as String?,
      url: map['url'] as String? ?? '',
      savedAt: map['savedAt'] != null
          ? DateTime.tryParse(map['savedAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookmarkItem.fromJson(String source) =>
      BookmarkItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type;

  @override
  int get hashCode => id.hashCode ^ type.hashCode;
}
