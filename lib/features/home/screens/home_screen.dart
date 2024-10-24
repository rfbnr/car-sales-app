import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/screens/login_screen.dart';
import '../widgets/section_profile_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authLocalDatasource: AuthLocalDatasource(),
        authRemoteDatasource: AuthRemoteDatasource(),
      )..add(
          GetUserLogin(),
        ),
      child: const HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SectionProfileWidget(),
            const SpaceHeight(50),
            ButtonPrimary(
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: BlocBuilder<AuthBloc, AuthState>(
            //     builder: (context, state) {
            //       switch (state.status) {
            //         case AuthStatus.failure:
            //           return Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceAround,
            //             children: [
            //               MainMenuWidget(
            //                 label: "Pengajuan saya",
            //                 icon: Icons.article_outlined,
            //                 onTap: () {},
            //               ),
            //               const SpaceHeight(30),
            //               MainMenuWidget(
            //                 label: "Buat Pengajuan Jasa",
            //                 icon: Icons.note_add_outlined,
            //                 onTap: () {},
            //               ),
            //               const SpaceHeight(30),
            //               MainMenuWidget(
            //                 label: "Cek Biaya Pajak",
            //                 icon: Icons.payments_outlined,
            //                 onTap: () {},
            //               ),
            //             ],
            //           );

            //         case AuthStatus.success:
            //           final data = state.dataLogin!.data!;

            //           return data.roles == "owner" || data.roles == "admin"
            //               ? const SizedBox.shrink()
            //               : Column(
            //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                   children: [
            //                     MainMenuWidget(
            //                       label: "Pengajuan saya",
            //                       icon: Icons.article_outlined,
            //                       onTap: () {
            //                         Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                             builder: (context) {
            //                               return UserTransactionScreen(
            //                                 userId: data.id ?? 0,
            //                               );
            //                             },
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                     const SpaceHeight(30),
            //                     MainMenuWidget(
            //                       label: "Buat Pengajuan Jasa",
            //                       icon: Icons.note_add_outlined,
            //                       onTap: () {
            //                         Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                             builder: (context) {
            //                               return const RequestTransactionScreen();
            //                             },
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                     const SpaceHeight(30),
            //                     MainMenuWidget(
            //                       label: "Cek Biaya Estimasi",
            //                       icon: Icons.payments_outlined,
            //                       onTap: () {
            //                         Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                             builder: (context) {
            //                               return const CheckBiayaScreen();
            //                             },
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                     const SpaceHeight(30),
            //                   ],
            //                 );

            //         default:
            //           return const SizedBox.shrink();
            //       }
            //     },
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: BlocBuilder<AuthBloc, AuthState>(
            //     builder: (context, state) {
            //       switch (state.status) {
            //         case AuthStatus.failure:
            //           return Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceAround,
            //             children: [
            //               MainMenuWidget(
            //                 label: "Seluruh Pengajuan *error",
            //                 icon: Icons.event_note_outlined,
            //                 onTap: () {},
            //               ),
            //               const SpaceHeight(30),
            //               MainMenuWidget(
            //                 label: "Kelola Report *error",
            //                 icon: Icons.report_outlined,
            //                 onTap: () {},
            //               ),
            //             ],
            //           );

            //         case AuthStatus.success:
            //           final data = state.dataLogin!.data!;

            //           return data.roles == "user"
            //               ? const SizedBox.shrink()
            //               : Column(
            //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                   children: [
            //                     MainMenuWidget(
            //                       label: "Seluruh Pengajuan Jasa",
            //                       icon: Icons.event_note_outlined,
            //                       onTap: () {
            //                         Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                             builder: (context) {
            //                               return const AllTransactionScreen();
            //                             },
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                     const SpaceHeight(30),
            //                     MainMenuWidget(
            //                       label: "Kelola Report Jasa",
            //                       icon: Icons.report_outlined,
            //                       onTap: () {
            //                         Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                             builder: (context) {
            //                               return const ReportTransactionScreen();
            //                             },
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                   ],
            //                 );

            //         default:
            //           return const SizedBox.shrink();
            //       }
            //     },
            //   ),
            // ),
            SpaceHeight(80),
          ],
        ),
      ),
    );
  }
}
