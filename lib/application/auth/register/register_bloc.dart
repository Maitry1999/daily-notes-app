import 'package:dartz/dartz.dart';
import 'package:e_dashboard/domain/auth/account_failure.dart';
import 'package:e_dashboard/domain/auth/auth_value_objects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'register_state.dart';
part 'register_event.dart';
part 'register_bloc.freezed.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.initial()) {
    on<RegisterEvent>(
      (event, emit) async {
        await event.map(
          emailChanged: (e) async => emit(
            state.copyWith(
              emailAddress: EmailAddress(e.emailStr),
            ),
          ),
          passwordChanged: (e) async => emit(
            state.copyWith(
              password: Password(e.passwordStr),
            ),
          ),
          confirmPasswordChanged: (e) async => emit(
            state.copyWith(
              password: Password(e.passwordStr),
            ),
          ),
          registerPressed: (e) async => emit(state),
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
