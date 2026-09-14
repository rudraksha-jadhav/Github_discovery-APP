import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/data/models/rate_limit_info.dart';

void main() {
  group('RateLimitInfo', () {
    test('parses rate limit API response correctly', () {
      final json = {
        'resources': {
          'core': {
            'limit': 60,
            'remaining': 45,
            'reset': 1700000000,
            'used': 15,
          }
        }
      };

      final info = RateLimitInfo.fromJson(json);

      expect(info.limit, equals(60));
      expect(info.remaining, equals(45));
      expect(info.used, equals(15));
      expect(info.usageFraction, closeTo(0.25, 0.01));
    });

    test('handles fallback when core is missing', () {
      final json = <String, dynamic>{
        'limit': 60,
        'remaining': 60,
        'reset': 0,
      };

      final info = RateLimitInfo.fromJson(json);

      expect(info.limit, equals(60));
      expect(info.remaining, equals(60));
      expect(info.used, equals(0));
      expect(info.usageFraction, equals(0.0));
    });
  });
}
