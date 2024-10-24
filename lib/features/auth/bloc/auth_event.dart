part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class VisibilityPassword extends AuthEvent {
  final bool newValue;

  const VisibilityPassword(this.newValue);

  @override
  List<Object> get props => [newValue];
}

class UserLogin extends AuthEvent {
  final String email;
  final String password;

  const UserLogin({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class UserRegister extends AuthEvent {
  final RegisterRequestBodyModel bodyRequestRegister;

  const UserRegister({
    required this.bodyRequestRegister,
  });

  @override
  List<Object> get props => [bodyRequestRegister];
}

class GetUserLogin extends AuthEvent {}

class UserLogout extends AuthEvent {}

class AuthSetInitial extends AuthEvent {}
