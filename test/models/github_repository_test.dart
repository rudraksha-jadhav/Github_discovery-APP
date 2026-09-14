import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/data/models/github_repository.dart';

void main() {
  group('GithubRepository JSON parsing', () {
    test('parses full repository payload correctly', () {
      final json = {
        'name': 'Spoon-Knife',
        'full_name': 'octocat/Spoon-Knife',
        'html_url': 'https://github.com/octocat/Spoon-Knife',
        'description': 'This repo is for spoon-knife practice',
        'language': 'HTML',
        'stargazers_count': 12000,
        'forks_count': 135000,
        'updated_at': '2024-01-15T12:00:00Z',
        'fork': false,
      };

      final repo = GithubRepository.fromJson(json);

      expect(repo.name, 'Spoon-Knife');
      expect(repo.fullName, 'octocat/Spoon-Knife');
      expect(repo.htmlUrl, 'https://github.com/octocat/Spoon-Knife');
      expect(repo.description, 'This repo is for spoon-knife practice');
      expect(repo.language, 'HTML');
      expect(repo.stargazersCount, 12000);
      expect(repo.forksCount, 135000);
      expect(repo.updatedAt, DateTime.parse('2024-01-15T12:00:00Z'));
      expect(repo.fork, false);
    });

    test('handles null description and language safely', () {
      final json = {
        'name': 'minimal-repo',
        'full_name': 'user/minimal-repo',
        'html_url': 'https://github.com/user/minimal-repo',
      };

      final repo = GithubRepository.fromJson(json);

      expect(repo.name, 'minimal-repo');
      expect(repo.fullName, 'user/minimal-repo');
      expect(repo.description, isNull);
      expect(repo.language, isNull);
      expect(repo.stargazersCount, 0);
      expect(repo.forksCount, 0);
      expect(repo.updatedAt, isNull);
      expect(repo.fork, false);
    });
  });
}
