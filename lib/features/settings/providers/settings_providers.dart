import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/rate_limit_info.dart';
import '../../github_search/providers/github_providers.dart';

final rateLimitStatusProvider = FutureProvider.autoDispose<RateLimitInfo>((ref) async {
  final apiService = ref.watch(githubApiServiceProvider);
  return apiService.getRateLimitStatus();
});
