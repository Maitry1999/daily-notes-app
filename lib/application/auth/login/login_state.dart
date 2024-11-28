part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    required bool isSubmitting,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
    required EmailAddress emailAddress,
    required Password password,
  }) = _LoginState;
  factory LoginState.initial() => LoginState(
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
        emailAddress: EmailAddress(''),
        password: Password(''),
      );
}
