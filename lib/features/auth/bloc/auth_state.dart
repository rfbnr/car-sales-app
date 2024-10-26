part of 'auth_bloc.dart';

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
  final SuccessResponseModel? success;

  const AuthState({
    this.status = AuthStatus.initial,
    this.logoutStatus = LogoutStatus.initial,
    this.dataLogin,
    this.dataRegister,
    this.showPassword = true,
    this.messageLogout,
    this.error,
    this.success,
  });

  AuthState copyWith({
    AuthStatus? status,
    LogoutStatus? logoutStatus,
    LoginResponseModel? dataLogin,
    RegisterResponseModel? dataRegister,
    bool? showPassword,
    String? messageLogout,
    ErrorResponseModel? error,
    SuccessResponseModel? success,
  }) {
    return AuthState(
      status: status ?? this.status,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      dataLogin: dataLogin ?? this.dataLogin,
      dataRegister: dataRegister ?? this.dataRegister,
      showPassword: showPassword ?? this.showPassword,
      messageLogout: messageLogout ?? this.messageLogout,
      error: error ?? this.error,
      success: success ?? this.success,
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
        success,
      ];
}
