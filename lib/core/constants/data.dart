import 'package:intl/intl.dart';

String formatDateView(DateTime? date) {
  if (date == null) return "Select Date";
  return DateFormat("dd-MM-yyyy").format(date);
}

String formatDateSend(DateTime? date) {
  if (date == null) return "Select Date";
  return DateFormat("yyyy-MM-dd").format(date);
}

final List<Map<String, dynamic>> opsiCarData = [
  {
    'opsiId': 1,
    'opsiName': "Input manual data Mobil",
  },
  {
    'opsiId': 2,
    'opsiName': "Pilih dari daftar Mobil",
  },
];

final List<Map<String, dynamic>> carDatas = [
  {
    'carId': 1,
    'carCode': "AVZ-0139",
    'carName': "Avanza Veloz",
    'carMerk': "Toyota",
    'carColor': "Hitam",
    'carImage': "assets/images/avanza.jpg",
    'carYear': 2023,
    'price': 292900000,
  },
  {
    'carId': 2,
    'carCode': "HRV-0192",
    'carName': "HR-V",
    'carMerk': "Honda",
    'carColor': "Hitam",
    'carImage': "assets/images/hrv.png",
    'carYear': 2024,
    'price': 383900000,
  },
  {
    'carId': 3,
    'carCode': "INV-1856",
    'carName': "Innova Reborn",
    'carMerk': "Toyota",
    'carColor': "Putih",
    'carImage': "assets/images/inova.png",
    'carYear': 2023,
    'price': 431900000,
  },
  {
    'carId': 4,
    'carCode': "PJR-0923",
    'carName': "Pejero Sport",
    'carMerk': "Mitsubishi",
    'carColor': "Hitam",
    'carImage': "assets/images/pajero.jpg",
    'carYear': 2023,
    'price': 767200000,
  },
  {
    'carId': 5,
    'carCode': "YRS-1278",
    'carName': "Yaris",
    'carMerk': "Toyota",
    'carColor': "Putih",
    'carImage': "assets/images/yaris.png",
    'carYear': 2022,
    'price': 345400000,
  },
];
