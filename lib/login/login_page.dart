import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/login/login_bloc.dart';
import 'package:login_bloc/login/login_event.dart';
import 'package:login_bloc/login/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isSuccessfull) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Successfull login')));
                return;
              }
            },
            builder: (context, state) {
              var loginBloc = context.read<LoginBloc>();
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 10,
                    ),
                    child: Text(
                      'Email Address',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: Colors.blueGrey),
                    ),
                  ),
                  AuthTextfieldWidget(
                    hintText: 'johndoe@xyz.com',
                    onChanged: (value) {
                      loginBloc.add(EmailChanged(value));
                    },
                  ),

                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 10,
                    ),
                    child: Text(
                      'Password',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: Colors.blueGrey),
                    ),
                  ),
                  AuthTextfieldWidget(
                    suffixIcon: Icon(Icons.visibility_off),
                    onChanged: (value) {
                      loginBloc.add(PasswordChanged(value));
                    },
                  ),
                  SizedBox(height: 30),
                  state.errorMessage.isEmpty
                      ? SizedBox()
                      : Text(
                          state.errorMessage,
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(color: Colors.red),
                        ),
                  GestureDetector(
                    onTap: () {
                      loginBloc.add(LoginSubmitted());
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                          colors: [Color(0xff16a085), Color(0xfff4d03f)],
                          stops: [0, 1],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: state.isSubmitting
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Login',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class AuthTextfieldWidget extends StatelessWidget {
  final Widget? suffixIcon;
  final String? hintText;
  final void Function(String)? onChanged;
  const AuthTextfieldWidget({
    super.key,
    this.suffixIcon,
    this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(50),
        ),
        fillColor: Color(0xfff5f5f5),
        filled: true,
      ),
    );
  }
}
