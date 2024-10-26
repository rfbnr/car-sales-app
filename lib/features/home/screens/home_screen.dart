import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/spaces.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../transaction/screens/transaction_history_screen.dart';
import '../../transaction/screens/transaction_request_screen.dart';
import '../../vehicle/screens/vehicle_screen.dart';
import '../widgets/main_menu_widget.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  MainMenuWidget(
                    label: "Daftar Mobil",
                    icon: Icons.car_repair_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const VehicleScreen();
                          },
                        ),
                      );
                    },
                  ),
                  const SpaceHeight(30),
                  MainMenuWidget(
                    label: "Form Pembelian",
                    icon: Icons.article_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const TransactionRequestScreen();
                          },
                        ),
                      );
                    },
                  ),
                  const SpaceHeight(30),
                  MainMenuWidget(
                    label: "Riwayat Pembelian",
                    icon: Icons.history,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const TransactionHistoryScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SpaceHeight(80),
          ],
        ),
      ),
    );
  }
}
