import 'dart:async';
import 'dart:developer';

import 'package:saree3_mobile/core/services/api_service.dart';
import 'package:saree3_mobile/core/services/token_manager.dart';
import 'package:workmanager/workmanager.dart';

import '../constants/token_key.dart';

class BackgroundServiceManager {
  static final ApiService apiService = ApiService(); 
  static Future<void> callbackDispatcher() async {
    Workmanager().executeTask((task, inputData) async {
      bool res = false;
      try {
        if (task == refreshTaskKey) {
          res = await TokenManager.refreshToken(apiService: apiService);
        }
      } catch (e) {
        log('Error in background task: $e');
      }
      return Future.value(res);
    });
  }

  // Initialize WorkManager
  static void initialize() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true, // Set to false for production
    );
  }

  // Schedule periodic token refresh
  static void scheduleTokenRefresh() {
    Workmanager().registerPeriodicTask(
      refreshTaskKey,
      refreshTaskKey,
      frequency: const Duration(minutes: 58), // Minimum interval is 15 minutes
    );
  }

  // Cancel scheduled token refresh
  static void cancelTokenRefresh() {
    Workmanager().cancelByUniqueName(refreshTaskKey);
  }

// Call initialize() once in the app's main function.
// Call scheduleTokenRefresh() after login.
// Call cancelTokenRefresh() on logout.
}
