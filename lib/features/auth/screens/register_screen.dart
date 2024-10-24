import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../../data/models/request/register_request_body_model.dart';
import '../bloc/auth_bloc.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authLocalDatasource: AuthLocalDatasource(),
        authRemoteDatasource: AuthRemoteDatasource(),
      ),
      child: const RegisterScreenView(),
    );
  }
}

class RegisterScreenView extends StatefulWidget {
  const RegisterScreenView({super.key});

  @override
  State<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          "Registrasi Akun",
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
            "Silahkan registrasi untuk membuat akun baru anda.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.black,
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(
            controller: nameController,
            label: "Nama Lengkap",
          ),
          const SpaceHeight(20.0),
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
                controller: passwordController,
                label: "Password",
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
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Berhasil Registrasi");

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
                titleButton: "Buat Akun",
                width: double.infinity,
                onPressed: () {
                  final body = RegisterRequestBodyModel(
                    email: emailController.text,
                    password: passwordController.text,
                    name: nameController.text,
                  );

                  context.read<AuthBloc>().add(
                        UserRegister(
                          bodyRequestRegister: body,
                        ),
                      );
                },
              );
            },
          ),
          const SpaceHeight(20.0),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }),
              );
            },
            child: const Text(
              "Sudah mempunyai akun? Login disini.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
              ),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
