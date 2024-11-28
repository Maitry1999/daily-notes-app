import 'package:e_dashboard/domain/account/account.dart';
import 'package:e_dashboard/domain/auth/account_failure.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthFacade {
  Future<bool> checkAuthenticated();

  Future<void> logout();

  Future<Either<AuthFailure, Unit>> registerUserData(Account account);
}
