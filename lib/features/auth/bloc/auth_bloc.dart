import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../../data/models/request/forgot_password_request_body_model.dart';
import '../../../data/models/request/register_request_body_model.dart';
import '../../../data/models/response/error_response_model.dart';
import '../../../data/models/response/login_response_model.dart';
import '../../../data/models/response/register_response_model.dart';
import '../../../data/models/response/success_response_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthBloc({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  }) : super(const AuthState()) {
    on<VisibilityPassword>(_onVisibilityPassword);
    on<UserLogin>(_onUserLogin);
    on<UserRegister>(_onUserRegister);
    on<UserForgotPassword>(_onUserForgotPassword);
    on<UserLogout>(_onUserLogout);
    on<GetUserLogin>(_onGetUserLogin);

    on<AuthSetInitial>(_onAuthSetInitial);
  }

  FutureOr<void> _onVisibilityPassword(
    VisibilityPassword event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(showPassword: !event.newValue),
    );
  }

  FutureOr<void> _onAuthSetInitial(
    AuthSetInitial event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        status: AuthStatus.initial,
        logoutStatus: LogoutStatus.initial,
      ),
    );
  }

  Future<void> _onUserLogin(
    UserLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    await Future.delayed(
        const Duration(
          seconds: 1,
        ), () async {
      try {
        final response = await authRemoteDatasource.login(
          email: event.email,
          password: event.password,
        );

        response.fold(
          (l) {
            emit(
              state.copyWith(
                status: AuthStatus.failure,
                error: l,
              ),
            );
            add(AuthSetInitial());
          },
          (r) {
            authLocalDatasource.saveAuthData(r);

            emit(
              state.copyWith(
                status: AuthStatus.success,
                dataLogin: r,
              ),
            );
            add(AuthSetInitial());
          },
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            error: ErrorResponseModel(
              status: 404,
              message: e.toString(),
            ),
          ),
        );
        add(AuthSetInitial());
      }
    });
  }

  Future<void> _onUserRegister(
    UserRegister event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    await Future.delayed(
        const Duration(
          seconds: 1,
        ), () async {
      try {
        final response = await authRemoteDatasource.register(
          bodyRequestRegister: event.bodyRequestRegister,
        );

        response.fold(
          (l) {
            emit(
              state.copyWith(
                status: AuthStatus.failure,
                error: l,
              ),
            );
            add(AuthSetInitial());
          },
          (r) {
            emit(
              state.copyWith(
                status: AuthStatus.success,
                dataRegister: r,
              ),
            );
            add(AuthSetInitial());
          },
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            error: ErrorResponseModel(
              status: 404,
              message: e.toString(),
            ),
          ),
        );
        add(AuthSetInitial());
      }
    });
  }

  Future<void> _onGetUserLogin(
    GetUserLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    try {
      final response = await authLocalDatasource.getAuthData();

      emit(
        state.copyWith(
          status: AuthStatus.success,
          dataLogin: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          error: ErrorResponseModel(
            status: 404,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _onUserForgotPassword(
    UserForgotPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    await Future.delayed(
        const Duration(
          seconds: 1,
        ), () async {
      try {
        final response = await authRemoteDatasource.forgotPassword(
          body: event.body,
        );

        response.fold(
          (l) {
            emit(
              state.copyWith(
                status: AuthStatus.failure,
                error: l,
              ),
            );
            add(AuthSetInitial());
          },
          (r) {
            emit(
              state.copyWith(
                status: AuthStatus.success,
                success: r,
              ),
            );
            add(AuthSetInitial());
          },
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            error: ErrorResponseModel(
              status: 404,
              message: e.toString(),
            ),
          ),
        );
        add(AuthSetInitial());
      }
    });
  }

  Future<void> _onUserLogout(
    UserLogout event,
    Emitter<AuthState> emit,
  ) async {
    await authRemoteDatasource.logout();
    // emit(
    //   state.copyWith(
    //     logoutStatus: LogoutStatus.loading,
    //   ),
    // );

    // await Future.delayed(
    //     const Duration(
    //       seconds: 1,
    //     ), () async {
    //   try {
    //     final response = await authRemoteDatasource.logout();

    //     response.fold(
    //       (l) {
    //         emit(
    //           state.copyWith(
    //             logoutStatus: LogoutStatus.failure,
    //             messageLogout: l,
    //           ),
    //         );
    //       },
    //       (r) {
    //         emit(
    //           state.copyWith(
    //             logoutStatus: LogoutStatus.success,
    //             messageLogout: r,
    //           ),
    //         );

    //         authLocalDatasource.removeAuthData();

    //         add(AuthSetInitial());
    //       },
    //     );
    //   } catch (e) {
    //     emit(
    //       state.copyWith(
    //         logoutStatus: LogoutStatus.failure,
    //         error: ErrorResponseModel(
    //           status: 404,
    //           message: e.toString(),
    //         ),
    //       ),
    //     );
    //   }
    // });
  }
}
