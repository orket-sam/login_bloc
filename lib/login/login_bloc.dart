import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/login/login_event.dart';
import 'package:login_bloc/login/login_service.dart';
import 'package:login_bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<PasswordChanged>(
      (event, emit) => emit(state.copyWith(password: event.password)),
    );

    on<EmailChanged>((event, emit) => emit(state.copyWith(email: event.email)));
    on<LoginSubmitted>((event, emit) async {
      try {
        emit(state.copyWith(isSubmitting: true, errorMessage: ''));

        if (state.email.isEmpty || state.password.isEmpty) {
          emit(
            state.copyWith(
              isSubmitting: false,
              errorMessage: 'Email and password required',
            ),
          );
          return;
        }
        var response = await LoginService()
            .signIn(state.email, state.password)
            .timeout(Duration(seconds: 10));
        if (response == null) {
          emit(
            state.copyWith(
              isSubmitting: false,
              errorMessage: 'Please try again',
            ),
          );
        } else {
          if (response.statusCode == 401) {
            emit(
              state.copyWith(
                isSubmitting: false,
                errorMessage: 'Invalid credentials',
              ),
            );
          }
          print(response.statusCode);
          if (response.statusCode == 200) {
            emit(state.copyWith(isSubmitting: false, isSuccessfull: true));
          }
        }
      } on TimeoutException {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: 'Request took too long please try again',
          ),
        );
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
      }
    });
  }
}
