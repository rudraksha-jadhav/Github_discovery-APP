import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/github_repository.dart';
import '../../github_search/providers/github_providers.dart';

class RepoCoordinates {
  final String owner;
  final String name;

  const RepoCoordinates({required this.owner, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepoCoordinates &&
          runtimeType == other.runtimeType &&
          owner == other.owner &&
          name == other.name;

  @override
  int get hashCode => owner.hashCode ^ name.hashCode;
}

class RepoDetailsData {
  final GithubRepository repository;
  final String readme;
  final Map<String, int> languages;

  const RepoDetailsData({
    required this.repository,
    required this.readme,
    required this.languages,
  });
}

final repoDetailsProvider =
    FutureProvider.family<RepoDetailsData, RepoCoordinates>((ref, coords) async {
  final apiService = ref.watch(githubApiServiceProvider);

  final repoFuture = apiService.getRepository(coords.owner, coords.name);
  final readmeFuture = apiService.getReadme(coords.owner, coords.name);
  final langsFuture = apiService.getLanguages(coords.owner, coords.name);

  final results = await Future.wait([repoFuture, readmeFuture, langsFuture]);

  return RepoDetailsData(
    repository: results[0] as GithubRepository,
    readme: results[1] as String,
    languages: results[2] as Map<String, int>,
  );
});
