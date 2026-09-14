// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GithubUser _$GithubUserFromJson(Map<String, dynamic> json) => _GithubUser(
  login: json['login'] as String,
  name: json['name'] as String?,
  avatarUrl: json['avatar_url'] as String? ?? '',
  htmlUrl: json['html_url'] as String? ?? '',
  bio: json['bio'] as String?,
  publicRepos: (json['public_repos'] as num?)?.toInt() ?? 0,
  followers: (json['followers'] as num?)?.toInt() ?? 0,
  following: (json['following'] as num?)?.toInt() ?? 0,
  company: json['company'] as String?,
  location: json['location'] as String?,
  blog: json['blog'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  type: json['type'] as String?,
);

Map<String, dynamic> _$GithubUserToJson(_GithubUser instance) =>
    <String, dynamic>{
      'login': instance.login,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'html_url': instance.htmlUrl,
      'bio': instance.bio,
      'public_repos': instance.publicRepos,
      'followers': instance.followers,
      'following': instance.following,
      'company': instance.company,
      'location': instance.location,
      'blog': instance.blog,
      'created_at': instance.createdAt?.toIso8601String(),
      'type': instance.type,
    };
