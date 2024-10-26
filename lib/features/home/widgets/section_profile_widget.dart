import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../profile/screens/profile_screen.dart';

class SectionProfileWidget extends StatelessWidget {
  const SectionProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE, d/M/y').format(now);

    return Container(
      height: 220,
      padding: const EdgeInsets.only(top: 40),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selamat Datang,",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SpaceHeight(6),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  switch (state.status) {
                    case AuthStatus.failure:
                      final error = state.error!;
                      return Center(
                        child: Text(error.message!),
                      );

                    case AuthStatus.success:
                      final data = state.dataLogin!.data!;

                      return Text(
                        data.name ?? "ERROR USER",
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      );

                    default:
                      return const Text(
                        "INITIAL NAME",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                        ),
                      );
                  }
                },
              ),
              const SpaceHeight(20),
              Text(
                formattedDate,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ProfileScreen();
                  },
                ),
              );
            },
            child: CircleAvatar(
              radius: 38,
              backgroundColor: AppColors.white.withOpacity(0.3),
              child: const Icon(
                Icons.person,
                size: 48,
                color: AppColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
