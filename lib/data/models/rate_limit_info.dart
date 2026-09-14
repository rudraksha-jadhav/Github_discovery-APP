class RateLimitInfo {
  final int limit;
  final int remaining;
  final int used;
  final DateTime resetTime;

  const RateLimitInfo({
    required this.limit,
    required this.remaining,
    required this.used,
    required this.resetTime,
  });

  factory RateLimitInfo.fromJson(Map<String, dynamic> json) {
    final resources = json['resources'] as Map<String, dynamic>?;
    final core = resources?['core'] as Map<String, dynamic>? ?? json;

    final limit = (core['limit'] as num?)?.toInt() ?? 60;
    final remaining = (core['remaining'] as num?)?.toInt() ?? 60;
    final used = (core['used'] as num?)?.toInt() ?? (limit - remaining);
    final resetSeconds = (core['reset'] as num?)?.toInt() ?? 0;
    final resetTime = resetSeconds > 0
        ? DateTime.fromMillisecondsSinceEpoch(resetSeconds * 1000)
        : DateTime.now().add(const Duration(hours: 1));

    return RateLimitInfo(
      limit: limit,
      remaining: remaining,
      used: used,
      resetTime: resetTime,
    );
  }

  double get usageFraction => limit > 0 ? (limit - remaining) / limit : 0.0;
  int get minutesUntilReset {
    final diff = resetTime.difference(DateTime.now()).inMinutes;
    return diff > 0 ? diff : 0;
  }
}
