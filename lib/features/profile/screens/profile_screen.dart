import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/screens/login_screen.dart';
import '../widgets/detail_data_profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(GetUserLogin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile Saya",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpaceHeight(40),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.grey.withOpacity(0.6),
                child: const Icon(
                  Icons.person,
                  size: 70,
                  color: AppColors.white,
                ),
              ),
            ),
            const SpaceHeight(60),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.grey2.withOpacity(0.4),
                borderRadius: BorderRadius.circular(18),
              ),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  switch (state.status) {
                    case AuthStatus.failure:
                      // final error = state.error!;

                      return const Column(
                        children: [
                          DetailDataProfileWidget(
                            title: "Nama",
                            value: "ERROR",
                          ),
                          SpaceHeight(10),
                          DetailDataProfileWidget(
                            title: "Email",
                            value: "ERROR",
                          ),
                          SpaceHeight(10),
                          DetailDataProfileWidget(
                            title: "Nomor Handphone",
                            value: "ERROR",
                          ),
                          SpaceHeight(10),
                          DetailDataProfileWidget(
                            title: "Nomor Polisi",
                            value: "ERROR",
                          ),
                          SpaceHeight(10),
                          DetailDataProfileWidget(
                            title: "Role Akun",
                            value: "ERROR",
                          ),
                          SpaceHeight(10),
                        ],
                      );

                    case AuthStatus.success:
                      final data = state.dataLogin!.data!;

                      return Column(
                        children: [
                          DetailDataProfileWidget(
                            title: "Nama",
                            value: data.name!,
                          ),
                          const SpaceHeight(10),
                          DetailDataProfileWidget(
                            title: "Email",
                            value: data.email ?? "-",
                          ),
                          const SpaceHeight(10),
                        ],
                      );

                    default:
                      return const Column(
                        children: [
                          DetailDataProfileWidget(
                            title: "Nama",
                            value: "loading...",
                          ),
                          SpaceHeight(10),
                          DetailDataProfileWidget(
                            title: "Email",
                            value: "loading...",
                          ),
                          SpaceHeight(10),
                        ],
                      );
                  }
                },
              ),
            ),
            const SpaceHeight(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonPrimary(
                titleButton: "Keluar",
                width: double.infinity,
                onPressed: () {
                  context.read<AuthBloc>().add(
                        UserLogout(),
                      );

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
