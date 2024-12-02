import 'package:dartz/dartz.dart';
import 'package:e_dashboard/domain/auth/account_failure.dart';
import 'package:e_dashboard/domain/auth/auth_value_objects.dart';
import 'package:e_dashboard/domain/auth/i_auth_facade.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';
part 'login_event.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthFacade authFacade;
  LoginBloc(this.authFacade) : super(LoginState.initial()) {
    on<LoginEvent>(
      (event, emit) async {
        await event.map(
          loginPressed: (e) async {
            Either<AuthFailure, String>? failureOrSuccess;

            final isEmailValid = state.emailAddress.isValid();
            final isPasswordValid = state.password.isValid();

            if (isEmailValid && isPasswordValid) {
              emit(
                state.copyWith(
                  isSubmitting: true,
                  authFailureOrSuccessOption: none(),
                ),
              );

              failureOrSuccess = await authFacade.login(
                emailAddress: state.emailAddress,
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
          emailChanged: (e) async {
            emit(
              state.copyWith(
                emailAddress: EmailAddress(e.emailStr),
              ),
            );
          },
          passwordChanged: (e) async {
            emit(
              state.copyWith(
                password: Password(e.passwordStr),
              ),
            );
          },
        );
      },
    );
  }
}
