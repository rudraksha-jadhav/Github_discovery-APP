import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_user.freezed.dart';
part 'github_user.g.dart';

@freezed
abstract class GithubUser with _$GithubUser {
  const factory GithubUser({
    required String login,
    String? name,
    @JsonKey(name: 'avatar_url', defaultValue: '') required String avatarUrl,
    @JsonKey(name: 'html_url', defaultValue: '') required String htmlUrl,
    String? bio,
    @JsonKey(name: 'public_repos', defaultValue: 0) required int publicRepos,
    @JsonKey(defaultValue: 0) required int followers,
    @JsonKey(defaultValue: 0) required int following,
    String? company,
    String? location,
    String? blog,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    String? type,
  }) = _GithubUser;

  factory GithubUser.fromJson(Map<String, dynamic> json) =>
      _$GithubUserFromJson(json);
}
