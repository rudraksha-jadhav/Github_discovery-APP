class GithubActivity {
  final String id;
  final String type;
  final String repoName;
  final DateTime? createdAt;
  final String actionTitle;
  final String? payloadDesc;

  const GithubActivity({
    required this.id,
    required this.type,
    required this.repoName,
    this.createdAt,
    required this.actionTitle,
    this.payloadDesc,
  });

  factory GithubActivity.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String? ?? 'Event';
    final repo = json['repo'] as Map<String, dynamic>?;
    final repoName = repo?['name'] as String? ?? 'repository';
    final createdAtStr = json['created_at'] as String?;
    final createdAt = createdAtStr != null ? DateTime.tryParse(createdAtStr) : null;

    final payload = json['payload'] as Map<String, dynamic>? ?? {};

    String actionTitle;
    String? payloadDesc;

    switch (type) {
      case 'PushEvent':
        final commits = payload['commits'] as List<dynamic>?;
        final count = commits?.length ?? 1;
        actionTitle = 'Pushed $count commit${count == 1 ? '' : 's'}';
        if (commits != null && commits.isNotEmpty) {
          final first = commits.first as Map<String, dynamic>?;
          payloadDesc = first?['message'] as String?;
        }
        break;
      case 'WatchEvent':
        actionTitle = 'Starred repository';
        break;
      case 'CreateEvent':
        final refType = payload['ref_type'] as String? ?? 'repository';
        actionTitle = 'Created $refType';
        break;
      case 'ForkEvent':
        actionTitle = 'Forked repository';
        break;
      case 'IssuesEvent':
        final action = payload['action'] as String? ?? 'opened';
        actionTitle = '${action.substring(0, 1).toUpperCase()}${action.substring(1)} issue';
        final issue = payload['issue'] as Map<String, dynamic>?;
        payloadDesc = issue?['title'] as String?;
        break;
      case 'PullRequestEvent':
        final action = payload['action'] as String? ?? 'opened';
        actionTitle = '${action.substring(0, 1).toUpperCase()}${action.substring(1)} pull request';
        final pr = payload['pull_request'] as Map<String, dynamic>?;
        payloadDesc = pr?['title'] as String?;
        break;
      default:
        actionTitle = type.replaceAll('Event', ' activity');
    }

    return GithubActivity(
      id: json['id'] as String? ?? DateTime.now().microsecondsSinceEpoch.toString(),
      type: type,
      repoName: repoName,
      createdAt: createdAt,
      actionTitle: actionTitle,
      payloadDesc: payloadDesc,
    );
  }
}
