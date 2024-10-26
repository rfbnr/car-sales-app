import 'package:flutter/material.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/data.dart';
import '../../../core/extensions/int_currency_ext.dart';
import '../widgets/detail_vehicle_item_widget.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.grey[100],
        title: const Text(
          'Daftar Mobil',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: carDatas.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SpaceHeight(10);
              },
              itemBuilder: (BuildContext context, int index) {
                final carData = carDatas[index];

                return Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              carData['carImage'],
                              width: 350,
                              // height: 100,
                            ),
                            const Divider(),
                            const SpaceHeight(10),
                            Text(
                              carData['carName'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SpaceHeight(16),
                            DetailVehicleItemWidget(
                              title: 'Code',
                              value: carData['carCode'],
                            ),
                            const SpaceHeight(5),
                            DetailVehicleItemWidget(
                              title: 'Merk',
                              value: carData['carMerk'],
                            ),
                            const SpaceHeight(5),
                            DetailVehicleItemWidget(
                              title: 'Warna',
                              value: carData['carColor'],
                            ),
                            const SpaceHeight(5),
                            DetailVehicleItemWidget(
                              title: 'Tahun',
                              value: carData['carYear'].toString(),
                            ),
                            const SpaceHeight(5),
                            DetailVehicleItemWidget(
                              title: 'Harga',
                              value: formatCurrencyRp(carData['price']),
                            ),
                            const SpaceHeight(5),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
