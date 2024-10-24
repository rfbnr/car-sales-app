part of 'auth_bloc.dart';

// sealed class AuthState extends Equatable {
//   const AuthState();

//   @override
//   List<Object> get props => [];
// }

// final class AuthInitial extends AuthState {}

enum AuthStatus { initial, loading, success, failure }

enum LogoutStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final AuthStatus? status;
  final LogoutStatus? logoutStatus;
  final LoginResponseModel? dataLogin;
  final RegisterResponseModel? dataRegister;
  final bool? showPassword;
  final String? messageLogout;
  final ErrorResponseModel? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.logoutStatus = LogoutStatus.initial,
    this.dataLogin,
    this.dataRegister,
    this.showPassword = true,
    this.messageLogout,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    LogoutStatus? logoutStatus,
    LoginResponseModel? dataLogin,
    RegisterResponseModel? dataRegister,
    bool? showPassword,
    String? messageLogout,
    ErrorResponseModel? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      dataLogin: dataLogin ?? this.dataLogin,
      dataRegister: dataRegister ?? this.dataRegister,
      showPassword: showPassword ?? this.showPassword,
      messageLogout: messageLogout ?? this.messageLogout,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        logoutStatus,
        dataLogin,
        dataRegister,
        showPassword,
        messageLogout,
        error,
      ];
}
