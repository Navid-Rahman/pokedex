import 'package:flutter/material.dart';

import '/core/app_colors.dart';
import '/core/app_logger.dart';

/// Utility class for displaying standardized dialogs across the app.
class PokedexDialogs {
  /// Shows a logout confirmation dialog with a consistent design.
  /// Returns `true` if the user confirms logout, `false` otherwise.
  static Future<bool> showLogoutDialog(BuildContext context) async {
    AppLogger.info('Showing logout confirmation dialog');
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: const Color(0xff1A1A1D),
        title: Text(
          'Log Out',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              AppLogger.info('Logout cancelled');
              Navigator.of(context).pop(false);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () {
              AppLogger.info('Logout confirmed');
              Navigator.of(context).pop(true);
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );

    return shouldLogout ?? false;
  }
}
