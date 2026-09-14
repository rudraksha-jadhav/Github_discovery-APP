// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GithubRepository _$GithubRepositoryFromJson(Map<String, dynamic> json) =>
    _GithubRepository(
      name: json['name'] as String,
      fullName: json['full_name'] as String? ?? '',
      htmlUrl: json['html_url'] as String? ?? '',
      description: json['description'] as String?,
      language: json['language'] as String?,
      stargazersCount: (json['stargazers_count'] as num?)?.toInt() ?? 0,
      forksCount: (json['forks_count'] as num?)?.toInt() ?? 0,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      fork: json['fork'] as bool? ?? false,
    );

Map<String, dynamic> _$GithubRepositoryToJson(_GithubRepository instance) =>
    <String, dynamic>{
      'name': instance.name,
      'full_name': instance.fullName,
      'html_url': instance.htmlUrl,
      'description': instance.description,
      'language': instance.language,
      'stargazers_count': instance.stargazersCount,
      'forks_count': instance.forksCount,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'fork': instance.fork,
    };
