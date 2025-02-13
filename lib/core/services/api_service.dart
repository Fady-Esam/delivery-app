import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:saree3_mobile/core/services/token_manager.dart';


class ApiService {
  final String baseUrl = 'https://api.themoviedb.org/3/';
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<Response?> makeRequest({
    required String endPoint,
    required String method,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    Response? res;
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    try {
      if (method == "GET") {
        res = await http.get(
          Uri.parse(baseUrl + endPoint),
          headers: headers,
        );
      } else if (method == "POST") {
        res = await http.post(
          Uri.parse(baseUrl + endPoint),
          body: jsonEncode(body),
          headers: headers,
        );
      }
      if (res != null && res.statusCode == 401) {
        // Unauthorized, try refreshing the token
        final refreshed = await TokenManager.refreshToken(apiService: _instance);
        if (refreshed) {
          return makeRequest(endPoint: endPoint, method: method,body: body);
        }
      }
    } catch (e) {}
    return res;
  }

  Future<Response> post({
    required String endPoint,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    var res = await http
        .post(Uri.parse(baseUrl + endPoint), body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    // if (res.statusCode == 401) {
    //   final refreshed = await TokenStorageService.refreshToken(context);
    //   if (refreshed) {
    //     res = await http.post(
    //       Uri.parse(baseUrl + endPoint),
    //       body: jsonEncode(body),
    //       headers: {
    //         "Content-Type": "application/json",
    //         "Accept": "application/json",
    //         "Authorization": "Bearer $token"
    //       },
    //     );
    //   }
    // }
    return res;
  }

  Future<Response> get(
      {required String endPoint,
      Map<String, String>? headers,
      String? token}) async {
    var res = await http.get(
      Uri.parse(baseUrl + endPoint),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    // if (res.statusCode == 401) {
    //   final refreshed = await TokenStorageService.refreshToken(context);
    //   if (refreshed) {
    //     res = await http.get(
    //       Uri.parse(baseUrl + endPoint),
    //       headers: {
    //         "Content-Type": "application/json",
    //         "Accept": "application/json",
    //         "Authorization": "Bearer $token"
    //       },
    //     );
    //   }
    // }
    return res;
  }
}
