import 'package:intl/intl.dart';

String formatDateView(DateTime? date) {
  if (date == null) return "Select Date";
  return DateFormat("dd-MM-yyyy").format(date);
}

String formatDateSend(DateTime? date) {
  if (date == null) return "Select Date";
  return DateFormat("yyyy-MM-dd").format(date);
}

final List<Map<String, dynamic>> statusTransactionData = [
  {
    'statusId': 1,
    'statusName': "Telah diterima sistem",
  },
  {
    'statusId': 2,
    'statusName': "On Proses kantor biro jasa",
  },
  {
    'statusId': 3,
    'statusName': "On Proses kantor samsat",
  },
  {
    'statusId': 4,
    'statusName': "Proses Selesai (Berkas dapat diambil)",
  },
  {
    'statusId': 5,
    'statusName': "Telah diserahkan",
  },
];

final List<Map<String, dynamic>> jenisKendaraanData = [
  {
    'kendaraanId': 1,
    'kendaraanName': "Motor",
  },
  {
    'kendaraanId': 2,
    'kendaraanName': "Mobil",
  },
];

final List<Map<String, dynamic>> jenisDokumenData = [
  {
    'dokumenId': 1,
    'dokumenName': "Perpanjang 1 Thn",
    'hargaDokumenMotor': 100000,
    'hargaDokumenMobil': 200000,
  },
  {
    'dokumenId': 2,
    'dokumenName': "Perpanjang 5 Thn",
    'hargaDokumenMotor': 150000,
    'hargaDokumenMobil': 250000,
  },
  {
    'dokumenId': 3,
    'dokumenName': "Balik Nama",
    'hargaDokumenMotor': 950000,
    'hargaDokumenMobil': 1300000,
  },
  {
    'dokumenId': 4,
    'dokumenName': "Mutasi Balik Nama",
    'hargaDokumenMotor': 1300000,
    'hargaDokumenMobil': 1700000,
  },
  {
    'dokumenId': 5,
    'dokumenName': "Mutasi Cabut/Keluar",
    'hargaDokumenMotor': 1100000,
    'hargaDokumenMobil': 1200000,
  },
  {
    'dokumenId': 6,
    'dokumenName': "Mutasi Masuk",
    'hargaDokumenMotor': 950000,
    'hargaDokumenMobil': 1300000,
  },
  {
    'dokumenId': 7,
    'dokumenName': "STNK Hilang",
    'hargaDokumenMotor': 500000,
    'hargaDokumenMobil': 700000,
  },
];
