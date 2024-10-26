import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../../data/models/request/forgot_password_request_body_model.dart';
import '../bloc/auth_bloc.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authLocalDatasource: AuthLocalDatasource(),
        authRemoteDatasource: AuthRemoteDatasource(),
      ),
      child: const ForgotPasswordScreenView(),
    );
  }
}

class ForgotPasswordScreenView extends StatefulWidget {
  const ForgotPasswordScreenView({super.key});

  @override
  State<ForgotPasswordScreenView> createState() =>
      _ForgotPasswordScreenViewState();
}

class _ForgotPasswordScreenViewState extends State<ForgotPasswordScreenView> {
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          "Lupa kata sandi",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          const SpaceHeight(20.0),
          const Text(
            "Silahkan masukkan email dan kata sandi baru anda untuk mereset kata sandi",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.black,
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(
            controller: emailController,
            label: "Email",
            keyboardType: TextInputType.emailAddress,
          ),
          const SpaceHeight(20.0),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final showPassword = state.showPassword;

              return CustomTextField(
                controller: newPasswordController,
                label: "Kata Sandi Baru",
                obscureText: showPassword!,
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.grey,
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          VisibilityPassword(showPassword),
                        );
                  },
                ),
              );
            },
          ),
          const SpaceHeight(54.0),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.loading) {
                EasyLoading.dismiss();
                EasyLoading.show(
                  status: "loading...",
                  dismissOnTap: false,
                  maskType: EasyLoadingMaskType.black,
                );
              } else if (state.status == AuthStatus.success) {
                final message =
                    state.success?.message ?? "Berhasil Reset Kata Sandi";

                EasyLoading.dismiss();
                EasyLoading.showSuccess(message);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }),
                  (route) => false,
                );
              } else if (state.status == AuthStatus.failure) {
                final error = state.error!;
                EasyLoading.dismiss();
                EasyLoading.showError(error.message!);
              }
            },
            builder: (context, state) {
              return ButtonPrimary(
                titleButton: "Reset Kata Sandi",
                width: double.infinity,
                onPressed: () {
                  final body = ForgotPasswordRequestBodyModel(
                    email: emailController.text,
                    newPassword: newPasswordController.text,
                  );

                  context.read<AuthBloc>().add(
                        UserForgotPassword(
                          body: body,
                        ),
                      );
                },
              );
            },
          ),
          const SpaceHeight(20.0),
        ],
      ),
    );
  }
}
