import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_dashboard/domain/account/account.dart';
import 'package:e_dashboard/domain/auth/account_failure.dart';
import 'package:e_dashboard/domain/auth/auth_value_objects.dart';
import 'package:e_dashboard/domain/auth/i_auth_facade.dart';
import 'package:e_dashboard/domain/core/api_constants.dart';
import 'package:e_dashboard/infrastructure/account/account_entity.dart';
import 'package:e_dashboard/infrastructure/account/current_user_dto.dart';
import 'package:e_dashboard/infrastructure/core/network/common_response.dart';
import 'package:e_dashboard/infrastructure/core/network/hive_box_names.dart';
import 'package:e_dashboard/infrastructure/core/network/injectable_module.dart';
import 'package:e_dashboard/presentation/common/utils/get_cookie.dart';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  final ApiService apiService;

  AuthFacade(this.apiService);

  @override
  Future<bool> checkAuthenticated() async {
    log('getUserToken() : ${getUserToken()}');
    // getCookie returns null as a String, so it has to be checked like this.
    return getUserToken() != null;
  }

  @override
  Future<Either<AuthFailure, String>> logout() async {
    try {
      return apiService.postMethod(ApiConstants.login, {"device_id": ''}).then(
          (value) async {
        Hive.box(BoxNames.settingsBox).clear();
        Hive.box<AccountEntity>(BoxNames.currentUser).clear();
        await Hive.box(BoxNames.settingsBox).put(BoxKeys.isUserShowIntro, true);
        return right(value?.dioMessage ?? "");
      });
      // await Future.wait([

      // ]);
      //  return right('');
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      }

      return left(const AuthFailure.serverError());
    }
  }

  Future<void> setUserToken(String authToken) async {
    // Hacky solution to allow testing
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      if (authToken.isNotEmpty) {
        await Hive.box(BoxNames.settingsBox).put(BoxKeys.userToken, authToken);
      }
    }
  }

  void _setUserData(Account account) {
    // Hacky solution to allow testing
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      final box = Hive.box<AccountEntity>(BoxNames.currentUser);
      box.put(BoxKeys.currentKey, AccountEntity.fromDomain(account));
    }
  }

  @override
  Future<Either<AuthFailure, String>> login(
      {required EmailAddress emailAddress, required Password password}) async {
    try {
      final response = await apiService.postMethod(
        ApiConstants.login,
        {
          "email": emailAddress.getOrCrash(),
          "password": password.getOrCrash(),
        },
      );

      if (response == null) {
        return left(AuthFailure.serverError());
      }
      final account = CurrentUserDTO.fromJson(response.data).toDomain();
      setUserToken(account.token ?? "");
      _setUserData(account);
      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }

      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, String>> register(
      {required EmailAddress emailAddress,
      required Password password,
      required Password confirmPassword}) async {
    try {
      var mapData = {
        "email": emailAddress.getOrCrash(),
        "password": password.getOrCrash(),
        "password_confirmation": confirmPassword.getOrCrash(),
      };

      final response = await apiService.postMethod(
        ApiConstants.register,
        mapData,
      );
      if (response == null) {
        return left(AuthFailure.serverError());
      } else {
        // final account = CurrentUserDTO.fromJson(response.data).toDomain();
        // setUserToken(account.token ?? "");
        // _setUserData(account);
        return right(response.dioMessage ?? "");
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      }

      return left(const AuthFailure.serverError());
    }
  }
}
