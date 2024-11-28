part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    required bool isSubmitting,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
    required EmailAddress emailAddress,
    required Password password,
    required Password confirmPassword,
    required Username userName,
  }) = _RegisterState;
  factory RegisterState.initial() => RegisterState(
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
        emailAddress: EmailAddress(''),
        password: Password(''),
        confirmPassword: Password(''),
        userName: Username(''),
      );
}
