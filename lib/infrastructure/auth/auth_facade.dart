import 'dart:developer';

import 'package:e_dashboard/domain/account/account.dart';
import 'package:e_dashboard/domain/auth/account_failure.dart';
import 'package:e_dashboard/domain/auth/i_auth_facade.dart';
import 'package:e_dashboard/infrastructure/account/account_entity.dart';
import 'package:e_dashboard/infrastructure/core/network/hive_box_names.dart';
import 'package:e_dashboard/presentation/common/utils/get_current_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  //final ApiService apiService;

  AuthFacade();

  @override
  Future<bool> checkAuthenticated() async {
    //log('getUserToken() : ${getCurrentUser()}');
    log('isCurrentUserExist: ${doesCurrentUserExist()}');
    if (doesCurrentUserExist()) {
      log('getCurrentUser() : ${getCurrentUser().map(
        (e) => AccountEntity.fromDomain(e).toDomain(),
      )}');
    }
    // getCookie returns null as a String, so it has to be checked like this.
    return doesCurrentUserExist();
  }

  @override
  Future<void> logout() async {
    Hive.box(BoxNames.settingsBox).clear();
    Hive.box(BoxNames.currentUser).clear();
    await Hive.box(BoxNames.settingsBox).put(BoxKeys.isUserShowIntro, true);
    // return right(value.dioMessage ?? "");
  }

  @override
  Future<Either<AuthFailure, Unit>> registerUserData(Account account) async {
    try {
      final box = Hive.box<AccountEntity>(BoxNames.currentUser);
      var listOfAccountEntity = <AccountEntity>[];
      if (doesCurrentUserExist()) {
        var res = getCurrentUser()..add(account);
        listOfAccountEntity = res
            .map(
              (e) => AccountEntity.fromDomain(e),
            )
            .toList();
      } else {
        listOfAccountEntity.add(AccountEntity.fromDomain(account));
      }
      return await box.add(AccountEntity.fromDomain(account)).then(
            (value) => right(unit),
          );
    } on PlatformException catch (e) {
      log('Error : ${e.message}');
      return left(const AuthFailure.serverError());
    }
  }
}
