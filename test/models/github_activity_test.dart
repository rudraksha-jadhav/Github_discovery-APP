import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/data/models/github_activity.dart';

void main() {
  group('GithubActivity', () {
    test('parses PushEvent with commit message correctly', () {
      final json = {
        'id': '12345',
        'type': 'PushEvent',
        'repo': {'name': 'flutter/flutter'},
        'payload': {
          'commits': [
            {'message': 'Fix layout overflow in widget tree'}
          ]
        },
        'created_at': '2024-01-01T12:00:00Z',
      };

      final activity = GithubActivity.fromJson(json);

      expect(activity.id, equals('12345'));
      expect(activity.type, equals('PushEvent'));
      expect(activity.repoName, equals('flutter/flutter'));
      expect(activity.actionTitle, equals('Pushed 1 commit'));
      expect(activity.payloadDesc, equals('Fix layout overflow in widget tree'));
    });

    test('parses WatchEvent as Starred repository', () {
      final json = {
        'id': '9999',
        'type': 'WatchEvent',
        'repo': {'name': 'dart-lang/sdk'},
      };

      final activity = GithubActivity.fromJson(json);

      expect(activity.actionTitle, equals('Starred repository'));
      expect(activity.repoName, equals('dart-lang/sdk'));
    });

    test('parses ForkEvent as Forked repository', () {
      final json = {
        'id': '8888',
        'type': 'ForkEvent',
        'repo': {'name': 'torvalds/linux'},
      };

      final activity = GithubActivity.fromJson(json);

      expect(activity.actionTitle, equals('Forked repository'));
      expect(activity.repoName, equals('torvalds/linux'));
    });
  });
}
