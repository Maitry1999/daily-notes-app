import 'package:dartz/dartz.dart';
import 'package:e_dashboard/domain/auth/account_failure.dart';
import 'package:e_dashboard/domain/auth/auth_value_objects.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, String>> register({
    required EmailAddress emailAddress,
    required Password password,
    required Password confirmPassword,
  });

  Future<Either<AuthFailure, String>> login(
      {required EmailAddress emailAddress, required Password password});

  Future<bool> checkAuthenticated();

  Future<Either<AuthFailure, String>> logout();
}
