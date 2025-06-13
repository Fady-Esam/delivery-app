import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:saree3_mobile/Features/auth/data/models/api_response.dart';
import 'package:saree3_mobile/Features/auth/data/models/auth_model.dart';
import 'package:saree3_mobile/Features/auth/data/models/log_in_model.dart';
import 'package:saree3_mobile/Features/auth/data/models/sign_up_model.dart';
import 'package:saree3_mobile/Features/auth/domain/repos/auth_repo.dart';
import 'package:saree3_mobile/core/services/api_service.dart';

import '../../../../core/services/token_manager.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl({required this.apiService});
  @override
  Future<Either<String, AuthModel>> logInWithEmailAndPassword({
    required LogInModel logInModel,
  }) async {
    try {
      var result = await apiService.makeRequest(
        endPoint: "api/Auth/log-in",
        method: "POST",
        body: {
          "email": logInModel.email,
          "phoneNumber" : logInModel.phoneNumber,
          "password": logInModel.password,
        },
      );
      if (result == null) {
        return left("Something went wrong, Please try again");
      }
      var apiResult = jsonDecode(result.body);
      var apiResponse = ApiResponse.fromJson(apiResult);
      var data = apiResponse.data;
      bool success = apiResponse.success;
      String errMessage = apiResponse.errMessage;
      log("Result ${data.toString()}");
      if (result.statusCode >= 400 || !success) {
        return left(errMessage);
      }
      var authModelData = AuthModel.fromJson(data);
      await TokenManager.saveTokens(
          authModelData.token, authModelData.refreshToken);
      //BackgroundServiceManager.scheduleTokenRefresh();
      return right(authModelData);
    } catch (e) {
      return left("Server Failure, Please try again");
    }
  }

  @override
  Future<Either<String, AuthModel>> signUpWithEmailAndPassword(
      {required SignUpModel signUpModel}) async {
    try {
      var result = await apiService.makeRequest(
        endPoint: "api/Auth/register",
        method: "POST",
        body: {
          "userName": signUpModel.userName,
          "email": signUpModel.email,
          "phoneNumber": signUpModel.phoneNumber,
          "password": signUpModel.password,
          "image" : signUpModel.image
        },
      );
      if (result == null) {
        return left("Something went wrong, Please try again");
      }
      var apiResult = jsonDecode(result.body);
      var apiResponse = ApiResponse.fromJson(apiResult);
      var data = apiResponse.data;
      bool success = apiResponse.success;
      String errMessage = apiResponse.errMessage;
      log("Result ${data.toString()}");
      if (result.statusCode >= 400 || !success) {
        return left(errMessage);
      }
      var authModelData = AuthModel.fromJson(data);
      await TokenManager.saveTokens(
          authModelData.token, authModelData.refreshToken);
      //BackgroundServiceManager.scheduleTokenRefresh();
      return right(authModelData);
    } catch (e) {
      return left("Server Failure, Please try again");
    }
  }
}
