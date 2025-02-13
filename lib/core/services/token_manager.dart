import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:saree3_mobile/core/services/api_service.dart';

import '../../Features/auth/data/models/api_response.dart';
import '../../Features/auth/data/models/auth_model.dart';

abstract class TokenManager {
  static final secureStorage = FlutterSecureStorage();

// Save tokens
  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    await secureStorage.write(key: 'accessToken', value: accessToken);
    await secureStorage.write(key: 'refreshToken', value: refreshToken);
  }

// Retrieve tokens
  static Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'accessToken');
  }

  static Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: 'refreshToken');
  }

// Delete tokens
  static Future<void> deleteTokens() async {
    await secureStorage.delete(key: 'accessToken');
    await secureStorage.delete(key: 'refreshToken');
  }

  static Future<void> deleteAccessToken() async {
    await secureStorage.delete(key: 'accessToken');
  }

  static Future<void> deleteRefreshToken() async {
    await secureStorage.delete(key: 'refreshToken');
  }

  static Future<bool> refreshToken({required ApiService apiService}) async {
    bool isSuccess = false;
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken != null) {
        var result = await apiService.makeRequest(
          endPoint: "api/Auth/register",
          method: "POST",
          body: {
            "refTokenString": refreshToken,
          },
        );
        if (result != null) {
          var apiResult = jsonDecode(result.body);
          var apiResponse = ApiResponse.fromJson(apiResult);
          var data = apiResponse.data;
          bool success = apiResponse.success;
          //String errMessage = apiResponse.errMessage;
          log("Result ${data.toString()}");
          if (success ||
              (result.statusCode >= 200 && result.statusCode < 300)) {
            var authModelData = AuthModel.fromJson(data);
            final newAccessToken =
                authModelData.token; // Adjust based on your API response
            final newRefreshToken =
                authModelData.refreshToken; // Adjust based on your API response
            await TokenManager.saveTokens(newAccessToken, newRefreshToken);
            isSuccess = true;
          }
        }
      }
    } catch (e) {}
    return isSuccess;
  }

  static Future<bool> revokeToken({required ApiService apiService}) async {
    bool isSuccess = false;
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken != null) {
        var result = await apiService.makeRequest(
          endPoint: "api/Auth/register",
          method: "POST",
          body: {
            "refTokenString": refreshToken,
          },
        );
        if (result != null) {
          var apiResult = jsonDecode(result.body);
          var apiResponse = ApiResponse.fromJson(apiResult);
          bool success = apiResponse.success;
          if (success || result.statusCode == 200 || result.statusCode == 201) {
            await deleteTokens();
            isSuccess = true;
          }
        }
      }
    } catch (e) {}
    return isSuccess;
  }
}
