class LoginState {
  final String password;
  final String email;
  final bool isSubmitting;
  final String errorMessage;
  final bool isSuccessfull;

  LoginState({
    required this.password,
    required this.email,
    required this.isSubmitting,
    required this.errorMessage,
    required this.isSuccessfull,
  });

  factory LoginState.initial() => LoginState(
    password: "",
    email: "",
    isSubmitting: false,
    isSuccessfull: false,
    errorMessage: "",
  );

  LoginState copyWith({
    String? password,
    String? email,
    bool? isSubmitting,
    bool? isSuccessfull,

    String? errorMessage,
  }) => LoginState(
    isSuccessfull: isSuccessfull ?? this.isSuccessfull,
    password: password ?? this.password,
    email: email ?? this.email,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
