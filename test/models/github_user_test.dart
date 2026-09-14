import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/data/models/github_user.dart';

void main() {
  group('GithubUser JSON parsing', () {
    test('parses full user payload correctly', () {
      final json = {
        'login': 'octocat',
        'name': 'The Octocat',
        'avatar_url': 'https://avatars.githubusercontent.com/u/583231?v=4',
        'html_url': 'https://github.com/octocat',
        'bio': 'GitHub mascot developer',
        'public_repos': 8,
        'followers': 20,
        'following': 2,
        'company': 'GitHub',
        'location': 'San Francisco',
        'blog': 'https://github.blog',
      };

      final user = GithubUser.fromJson(json);

      expect(user.login, 'octocat');
      expect(user.name, 'The Octocat');
      expect(user.avatarUrl, 'https://avatars.githubusercontent.com/u/583231?v=4');
      expect(user.htmlUrl, 'https://github.com/octocat');
      expect(user.bio, 'GitHub mascot developer');
      expect(user.publicRepos, 8);
      expect(user.followers, 20);
      expect(user.following, 2);
      expect(user.company, 'GitHub');
      expect(user.location, 'San Francisco');
      expect(user.blog, 'https://github.blog');
    });

    test('handles null and missing optional fields safely', () {
      final json = {
        'login': 'torvalds',
        'avatar_url': 'https://avatars.githubusercontent.com/u/1024025?v=4',
        'html_url': 'https://github.com/torvalds',
      };

      final user = GithubUser.fromJson(json);

      expect(user.login, 'torvalds');
      expect(user.name, isNull);
      expect(user.bio, isNull);
      expect(user.publicRepos, 0);
      expect(user.followers, 0);
      expect(user.following, 0);
      expect(user.company, isNull);
      expect(user.location, isNull);
      expect(user.blog, isNull);
    });
  });
}
