import 'package:dartz/dartz.dart';
import 'package:e_dashboard/domain/auth/account_failure.dart';
import 'package:e_dashboard/domain/auth/auth_value_objects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';
part 'login_event.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginEvent>(
      (event, emit) async {
        await event.map(
          loginPressed: (e) async {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
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
