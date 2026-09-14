import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/github_activity.dart';
import '../../../data/models/github_repository.dart';
import '../../../data/models/github_user.dart';
import '../../github_search/providers/github_providers.dart';

class ProfileDetailsData {
  final GithubUser user;
  final List<GithubRepository> repositories;
  final List<GithubActivity> activities;

  const ProfileDetailsData({
    required this.user,
    required this.repositories,
    required this.activities,
  });
}

final profileDetailsProvider =
    FutureProvider.family<ProfileDetailsData, String>((ref, username) async {
  final apiService = ref.watch(githubApiServiceProvider);
  final clean = username.trim();

  final userFuture = apiService.getUser(clean);
  final reposFuture = apiService.getRepositories(clean);
  final eventsFuture = apiService.getUserEvents(clean);

  final results = await Future.wait([userFuture, reposFuture, eventsFuture]);

  return ProfileDetailsData(
    user: results[0] as GithubUser,
    repositories: results[1] as List<GithubRepository>,
    activities: results[2] as List<GithubActivity>,
  );
});
