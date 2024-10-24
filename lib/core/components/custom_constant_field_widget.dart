import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'spaces.dart';
import '../constants/colors.dart';

class CustomConstantFieldWidget extends StatelessWidget {
  const CustomConstantFieldWidget({
    super.key,
    required this.label,
    required this.value,
    this.onTap,
  });

  final String label;
  final String value;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SpaceHeight(6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.black,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
