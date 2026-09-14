import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_repository.freezed.dart';
part 'github_repository.g.dart';

@freezed
abstract class GithubRepository with _$GithubRepository {
  const factory GithubRepository({
    required String name,
    @JsonKey(name: 'full_name', defaultValue: '') required String fullName,
    @JsonKey(name: 'html_url', defaultValue: '') required String htmlUrl,
    String? description,
    String? language,
    @JsonKey(name: 'stargazers_count', defaultValue: 0) required int stargazersCount,
    @JsonKey(name: 'forks_count', defaultValue: 0) required int forksCount,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(defaultValue: false) required bool fork,
  }) = _GithubRepository;

  factory GithubRepository.fromJson(Map<String, dynamic> json) =>
      _$GithubRepositoryFromJson(json);
}
