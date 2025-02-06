import 'package:dartz/dartz.dart';
import 'package:e_dashboard/domain/auth/account_failure.dart';
import 'package:e_dashboard/domain/auth/auth_value_objects.dart';
import 'package:e_dashboard/domain/auth/i_auth_facade.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'register_state.dart';
part 'register_event.dart';
part 'register_bloc.freezed.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final IAuthFacade _authFacade;
  RegisterBloc(this._authFacade) : super(RegisterState.initial()) {
    on<RegisterEvent>(
      (event, emit) async {
        await event.map(
          emailChanged: (e) async => emit(
            state.copyWith(
              emailAddress: EmailAddress(e.emailStr),
              authFailureOrSuccessOption: none(),
            ),
          ),
          passwordChanged: (e) async => emit(
            state.copyWith(
              authFailureOrSuccessOption: none(),
              password: Password(e.passwordStr),
            ),
          ),
          confirmPasswordChanged: (e) async => emit(
            state.copyWith(
              authFailureOrSuccessOption: none(),
              confirmPassword: Password(e.passwordStr),
            ),
          ),
          registerPressed: (e) async {
            Either<AuthFailure, String>? failureOrSuccess;

            final isEmailValid = state.emailAddress.isValid();
            final isPasswordValid = state.password.isValid();
            final isConfirmPasswordValid = state.confirmPassword.isValid();

            if (isEmailValid && isPasswordValid && isConfirmPasswordValid) {
              emit(
                state.copyWith(
                  isSubmitting: true,
                  authFailureOrSuccessOption: none(),
                ),
              );

              failureOrSuccess = await _authFacade.register(
                emailAddress: state.emailAddress,
                confirmPassword: state.confirmPassword,
                password: state.password,
              );
            }

            emit(
              state.copyWith(
                isSubmitting: false,
                showErrorMessages: true,
                authFailureOrSuccessOption: optionOf(failureOrSuccess),
              ),
            );
          },
          nameChanged: (value) async => emit(
            state.copyWith(
              userName: Username(value.nameStr),
            ),
          ),
        );
      },
    );
  }
}
