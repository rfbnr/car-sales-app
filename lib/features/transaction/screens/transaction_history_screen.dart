import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/extensions/int_currency_ext.dart';
import '../../../data/datasources/transaction_remote_datasource.dart';
import '../bloc/transaction_bloc.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc(
        transactionRemoteDatasource: TransactionRemoteDatasource(),
      )..add(
          TransactionLoadData(),
        ),
      child: const TransactionHistoryScreenView(),
    );
  }
}

class TransactionHistoryScreenView extends StatelessWidget {
  const TransactionHistoryScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: const Text(
          "Riwayat Pembelian",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SpaceHeight(20),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              switch (state.status) {
                case TransactionStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case TransactionStatus.failure:
                  final message = state.error!.message!;
                  return Center(
                    child: Text(message),
                  );

                case TransactionStatus.success:
                  final data = state.transaction!.data!;

                  return Column(
                    children: [
                      Text(
                        "Anda Memliki ${data.length} Riwayat Pembelian",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SpaceHeight(20),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: data.length,
                        separatorBuilder: (context, index) {
                          return const SpaceHeight(20);
                        },
                        itemBuilder: (context, index) {
                          final item = data[index];

                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ExpansionTile(
                              leading: const Icon(Icons.article),
                              visualDensity: VisualDensity.standard,
                              dense: false,
                              iconColor: AppColors.primary,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enableFeedback: false,
                              collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Text(
                                "Nomor Faktur: ${item.fakturNumber ?? "-"}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Mobil: ${item.car?.name ?? "-"}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              childrenPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              children: [
                                const Text(
                                  "Data Diri",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SpaceHeight(2),
                                CustomExpansionTileItemWidget(
                                  title: "Kode",
                                  value: item.buyer?.code ?? "-",
                                ),
                                CustomExpansionTileItemWidget(
                                  title: "Nama",
                                  value: item.buyer?.name ?? "-",
                                ),
                                CustomExpansionTileItemWidget(
                                  title: "Alamat",
                                  value: item.buyer?.address ?? "-",
                                ),
                                CustomExpansionTileItemWidget(
                                  title: "Pekerjaan",
                                  value: item.buyer?.job ?? "-",
                                ),
                                CustomExpansionTileItemWidget(
                                  title: "Nomor Handphone",
                                  value: item.buyer?.phoneNumber ?? "-",
                                ),
                                const SpaceHeight(14),
                                const Text(
                                  "Data Mobil",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SpaceHeight(2),
                                CustomExpansionTileItemWidget(
                                  title: "Kode Mobil",
                                  value: item.car?.code ?? "-",
                                ),
                                CustomExpansionTileItemWidget(
                                  title: "Nama Mobil",
                                  value: item.car?.name ?? "-",
                                ),
                                CustomExpansionTileItemWidget(
                                  title: "Merk Mobil",
                                  value: item.car?.merk ?? "-",
                                ),
                                CustomExpansionTileItemWidget(
                                  title: "Warna Mobil",
                                  value: item.car?.color ?? "-",
                                ),
                                CustomExpansionTileItemWidget(
                                  title: "Tahun Pembuatan",
                                  value: "${item.car?.year ?? "-"}",
                                ),
                                CustomExpansionTileItemWidget(
                                  title: "Harga Mobil",
                                  value: formatCurrencyRp(item.car?.price ?? 0),
                                ),
                                const SpaceHeight(16),
                                CustomExpansionTileItemWidget(
                                  title: "Nomor Faktur",
                                  value: item.fakturNumber ?? "Tidak Diketahui",
                                ),
                                CustomExpansionTileItemWidget(
                                  title: "Kode Transaksi",
                                  value: item.code ?? "Tidak Diketahui",
                                ),
                                CustomExpansionTileItemWidget(
                                  title: "Waktu Transaksi",
                                  value:
                                      item.transactionDate ?? "Tidak Diketahui",
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );

                default:
                  return const Center(
                    child: Text("Tunggu Sebentar"),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomExpansionTileItemWidget extends StatelessWidget {
  const CustomExpansionTileItemWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          width: size.width * 0.45,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
