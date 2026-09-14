import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper utility for safely opening URLs.
class UrlLauncherUtils {
  UrlLauncherUtils._();

  static Future<bool> openUrl(BuildContext context, String urlString) async {
    final uri = Uri.tryParse(urlString);
    if (uri == null) {
      _showError(context, 'Invalid URL');
      return false;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        _showError(context, 'Could not open link in browser.');
      }
      return launched;
    } catch (e) {
      if (context.mounted) {
        _showError(context, 'Could not launch link: $e');
      }
      return false;
    }
  }

  static Future<bool> launchGithubUrl(String urlString) async {
    final uri = Uri.tryParse(urlString);
    if (uri == null) return false;

    try {
      return await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      return false;
    }
  }

  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
