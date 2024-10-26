import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:car_sales_app/core/extensions/int_currency_ext.dart';
import 'package:car_sales_app/core/extensions/string_currency_ext.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_constant_field_widget.dart';
import '../../../core/components/custom_dropdown_widget.dart';
import '../../../core/components/custom_text_field_widget.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/data.dart';
import '../../../data/datasources/transaction_remote_datasource.dart';
import '../../../data/models/request/transaction_request_body_model.dart';
import '../../home/screens/home_screen.dart';
import '../bloc/transaction_bloc.dart';

class TransactionRequestScreen extends StatelessWidget {
  const TransactionRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc(
        transactionRemoteDatasource: TransactionRemoteDatasource(),
      ),
      child: const TransactionRequestScreenView(),
    );
  }
}

class TransactionRequestScreenView extends StatefulWidget {
  const TransactionRequestScreenView({super.key});

  @override
  State<TransactionRequestScreenView> createState() =>
      _TransactionRequestScreenViewState();
}

class _TransactionRequestScreenViewState
    extends State<TransactionRequestScreenView> {
  bool? isManualData;

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final codeController = TextEditingController();
  final jobController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final fakturController = TextEditingController();
  final carNameController = TextEditingController();
  final carMerkController = TextEditingController();
  final carColorController = TextEditingController();
  final carYearController = TextEditingController();
  final carPriceController = TextEditingController();
  final carCodeController = TextEditingController();

  String? formatterDateNow;
  String? formatterDateSend;

  @override
  void initState() {
    final now = DateTime.now();
    formatterDateNow = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    formatterDateSend = DateFormat('dd/MM/yyyy').format(now);

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    codeController.dispose();
    jobController.dispose();
    phoneNumberController.dispose();

    fakturController.dispose();
    carNameController.dispose();
    carMerkController.dispose();
    carColorController.dispose();
    carYearController.dispose();
    carPriceController.dispose();
    carCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Formulir Pembelian",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        children: [
          const Text(
            "Data Identitas",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(16),
          CustomTextFieldWidget(
            label: "Nama Lengkap",
            controller: nameController,
          ),
          const SpaceHeight(10),
          CustomTextFieldWidget(
            label: "Alamat",
            controller: addressController,
          ),
          const SpaceHeight(10),
          Row(
            children: [
              Expanded(
                child: CustomTextFieldWidget(
                  label: "Pekerjaan",
                  controller: jobController,
                ),
              ),
              const SpaceWidth(10),
              Expanded(
                child: CustomTextFieldWidget(
                  label: "Nomor HP",
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            ],
          ),
          const SpaceHeight(40),
          CustomDropdownWidget<Map<String, dynamic>>(
            label: "Opsi Input Data Mobil",
            items: opsiCarData.map((e) {
              return DropdownMenuItem<Map<String, dynamic>>(
                value: e,
                child: Text(
                  e['opsiName'],
                ),
              );
            }).toList(),
            onChanged: (v) {
              if (v!['opsiName'].contains("Input manual")) {
                setState(() {
                  isManualData = true;
                  fakturController.text = "";
                  codeController.text = "";
                  carNameController.text = "";
                  carCodeController.text = "";
                  carMerkController.text = "";
                  carColorController.text = "";
                  carYearController.text = "";
                  carPriceController.text = "";
                });
              } else {
                setState(() {
                  isManualData = false;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Pilih Opsi Input Data Mobil";
              }
              return null;
            },
          ),
          const SpaceHeight(30),
          isManualData == null
              ? const SizedBox()
              : isManualData == true
                  ? CarInputManualWidget(
                      fakturController: fakturController,
                      codeController: codeController,
                      carNameController: carNameController,
                      carCodeController: carCodeController,
                      carMerkController: carMerkController,
                      carColorController: carColorController,
                      carYearController: carYearController,
                      carPriceController: carPriceController,
                    )
                  : CarInputFromList(
                      fakturController: fakturController,
                      codeController: codeController,
                      carNameController: carNameController,
                      carCodeController: carCodeController,
                      carMerkController: carMerkController,
                      carColorController: carColorController,
                      carYearController: carYearController,
                      carPriceController: carPriceController,
                    ),
          const SpaceHeight(50),
          isManualData == null
              ? const SizedBox()
              : BlocListener<TransactionBloc, TransactionState>(
                  listener: (context, state) {
                    if (state.status == TransactionStatus.loading) {
                      EasyLoading.dismiss();
                      EasyLoading.show(
                        status: "loading kirim data...",
                        dismissOnTap: false,
                        maskType: EasyLoadingMaskType.black,
                      );
                    } else if (state.status == TransactionStatus.failure) {
                      final message = state.error!.message;

                      EasyLoading.dismiss();
                      EasyLoading.showError(message!);
                    } else if (state.status == TransactionStatus.success) {
                      final message = state.success!.message;

                      EasyLoading.dismiss();
                      EasyLoading.showSuccess(message!);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomeScreen();
                          },
                        ),
                        (route) => false,
                      );
                    }
                  },
                  child: ButtonPrimary(
                    titleButton: "Kirim Formulir",
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          addressController.text.isEmpty ||
                          codeController.text.isEmpty ||
                          jobController.text.isEmpty ||
                          phoneNumberController.text.isEmpty ||
                          fakturController.text.isEmpty ||
                          carNameController.text.isEmpty ||
                          carMerkController.text.isEmpty ||
                          carColorController.text.isEmpty ||
                          carYearController.text.isEmpty ||
                          carPriceController.text.isEmpty ||
                          carCodeController.text.isEmpty) {
                        EasyLoading.showError("Semua data wajib diisi");
                        return;
                      }

                      final bodyTransaction = TransactionRequestBodyModel(
                        transactionDate: formatterDateNow,
                        buyerName: nameController.text,
                        buyerAddress: addressController.text,
                        buyerPhoneNumber: phoneNumberController.text,
                        buyerJob: jobController.text,
                        buyerCode: codeController.text,
                        fakturNumber: fakturController.text,
                        carName: carNameController.text,
                        merk: carMerkController.text,
                        color: carColorController.text,
                        year: int.parse(carYearController.text),
                        price: carPriceController.text.toIntegerFromText,
                        carCode: carCodeController.text,
                      );

                      print("___ ${bodyTransaction.toJson()}");

                      context.read<TransactionBloc>().add(
                            TransactionRequestForm(
                              body: bodyTransaction,
                            ),
                          );
                    },
                  ),
                ),
          const SpaceHeight(60),
        ],
      ),
    );
  }
}

class CarInputFromList extends StatefulWidget {
  const CarInputFromList({
    super.key,
    required this.fakturController,
    required this.codeController,
    required this.carNameController,
    required this.carCodeController,
    required this.carMerkController,
    required this.carColorController,
    required this.carYearController,
    required this.carPriceController,
  });

  final TextEditingController fakturController;
  final TextEditingController codeController;
  final TextEditingController carNameController;
  final TextEditingController carCodeController;
  final TextEditingController carMerkController;
  final TextEditingController carColorController;
  final TextEditingController carYearController;
  final TextEditingController carPriceController;

  @override
  State<CarInputFromList> createState() => _CarInputFromListState();
}

class _CarInputFromListState extends State<CarInputFromList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data Mobil",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SpaceHeight(16),
        CustomDropdownWidget<Map<String, dynamic>>(
          label: "Pilih Data Mobil dari List",
          items: carDatas.map((e) {
            return DropdownMenuItem<Map<String, dynamic>>(
              value: e,
              child: Text(
                e['carName'],
              ),
            );
          }).toList(),
          onChanged: (v) {
            final randomFktrNumber = Random().nextInt(100);
            final randomCustCode = Random().nextInt(100);

            setState(() {
              widget.fakturController.text = "FKTR-$randomFktrNumber";
              widget.codeController.text = "CUST-$randomCustCode";
              widget.carNameController.text = v!['carName'];
              widget.carCodeController.text = v['carCode'];
              widget.carMerkController.text = v['carMerk'];
              widget.carColorController.text = v['carColor'];
              widget.carYearController.text = "${v['carYear']}";
              widget.carPriceController.text = "${v['price']}";
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Pilih Data Mobil dari List";
            }
            return null;
          },
        ),
        const SpaceHeight(10),
        Row(
          children: [
            Expanded(
              child: CustomConstantFieldWidget(
                label: "Nomor Faktur",
                value: widget.fakturController.text,
              ),
            ),
            const SpaceWidth(10),
            Expanded(
              child: CustomConstantFieldWidget(
                label: "Kode Pembelian",
                value: widget.codeController.text,
              ),
            ),
          ],
        ),
        const SpaceHeight(10),
        CustomConstantFieldWidget(
          label: "Nama Mobil",
          value: widget.carNameController.text,
        ),
        const SpaceHeight(10),
        Row(
          children: [
            Expanded(
              child: CustomConstantFieldWidget(
                label: "Kode Mobil",
                value: widget.carCodeController.text,
              ),
            ),
            const SpaceWidth(10),
            Expanded(
              child: CustomConstantFieldWidget(
                label: "Merk Mobil",
                value: widget.carMerkController.text,
              ),
            ),
          ],
        ),
        const SpaceHeight(10),
        Row(
          children: [
            Expanded(
              child: CustomConstantFieldWidget(
                label: "Warna Mobil",
                value: widget.carColorController.text,
              ),
            ),
            const SpaceWidth(10),
            Expanded(
              child: CustomConstantFieldWidget(
                label: "Tahun Pembuatan",
                value: widget.carYearController.text,
              ),
            ),
          ],
        ),
        const SpaceHeight(10),
        CustomConstantFieldWidget(
          label: "Harga Mobil",
          value: formatCurrencyRp(
            widget.carPriceController.text.toIntegerFromText,
          ),
        ),
        const SpaceHeight(10),
      ],
    );
  }
}

class CarInputManualWidget extends StatefulWidget {
  const CarInputManualWidget({
    super.key,
    required this.fakturController,
    required this.codeController,
    required this.carNameController,
    required this.carCodeController,
    required this.carMerkController,
    required this.carColorController,
    required this.carYearController,
    required this.carPriceController,
  });

  final TextEditingController fakturController;
  final TextEditingController codeController;
  final TextEditingController carNameController;
  final TextEditingController carCodeController;
  final TextEditingController carMerkController;
  final TextEditingController carColorController;
  final TextEditingController carYearController;
  final TextEditingController carPriceController;

  @override
  State<CarInputManualWidget> createState() => _CarInputManualWidgetState();
}

class _CarInputManualWidgetState extends State<CarInputManualWidget> {
  @override
  void initState() {
    super.initState();
    final randomFktrNumber = Random().nextInt(100);
    final randomCustCode = Random().nextInt(100);

    widget.fakturController.text = "FKTR-$randomFktrNumber";
    widget.codeController.text = "CUST-$randomCustCode";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data Mobil",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SpaceHeight(16),
        Row(
          children: [
            Expanded(
              child: CustomConstantFieldWidget(
                label: "Nomor Faktur",
                value: widget.fakturController.text,
              ),
            ),
            const SpaceWidth(10),
            Expanded(
              child: CustomConstantFieldWidget(
                label: "Kode Pembelian",
                value: widget.codeController.text,
              ),
            ),
          ],
        ),
        const SpaceHeight(10),
        CustomTextFieldWidget(
          label: "Nama Mobil",
          controller: widget.carNameController,
        ),
        const SpaceHeight(10),
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWidget(
                label: "Kode Mobil",
                controller: widget.carCodeController,
              ),
            ),
            const SpaceWidth(10),
            Expanded(
              child: CustomTextFieldWidget(
                label: "Merk Mobil",
                controller: widget.carMerkController,
              ),
            ),
          ],
        ),
        const SpaceHeight(10),
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWidget(
                label: "Warna Mobil",
                controller: widget.carColorController,
              ),
            ),
            const SpaceWidth(10),
            Expanded(
              child: CustomTextFieldWidget(
                label: "Tahun Pembuatan",
                controller: widget.carYearController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ],
        ),
        const SpaceHeight(10),
        CustomTextFieldWidget(
          label: "Harga Mobil",
          controller: widget.carPriceController,
          onChanged: (v) {
            final value = v.toIntegerFromText;
            widget.carPriceController.text = formatCurrencyRp(value);
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
        const SpaceHeight(10),
      ],
    );
  }
}
