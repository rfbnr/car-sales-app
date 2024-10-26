import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../home/screens/home_screen.dart';
import '../bloc/auth_bloc.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authLocalDatasource: AuthLocalDatasource(),
        authRemoteDatasource: AuthRemoteDatasource(),
      ),
      child: const LoginScreenView(),
    );
  }
}

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/bg-car.jpg",
                // width: double.infinity,
                // height: 240,
              ),
            ),
            const SpaceHeight(24.0),
            const Text(
              "Car Sales App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SpaceHeight(10.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Silahkan login untuk melakukan transaksi beli mobil impian anda",
                textAlign: TextAlign.center,
              ),
            ),
            const SpaceHeight(40.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomTextField(
                controller: emailController,
                label: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SpaceHeight(20.0),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final showPassword = state.showPassword;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomTextField(
                    controller: passwordController,
                    label: "Kata Sandi",
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
                  ),
                );
              },
            ),
            const SpaceHeight(10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const ForgotPasswordScreen();
                  }),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Lupa Kata Sandi?",
                    style: TextStyle(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
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
                  final message = state.dataLogin?.message ?? "Berhasil Login";

                  EasyLoading.dismiss();
                  EasyLoading.showSuccess(message);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const HomeScreen();
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ButtonPrimary(
                    titleButton: "Masuk",
                    width: double.infinity,
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            UserLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    },
                  ),
                );
              },
            ),
            const SpaceHeight(20.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const RegisterScreen();
                  }),
                );
              },
              child: const Text(
                "Belum mempunyai akun? Register disini.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
