import 'package:flutter/material.dart';

import 'spaces.dart';
import '../constants/colors.dart';

class CustomDropdownWidget<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final String label;
  final void Function(T? value)? onChanged;
  final String? Function(T? value)? validator;

  const CustomDropdownWidget({
    super.key,
    required this.items,
    required this.label,
    required this.onChanged,
    this.validator,
    this.value,
  });

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
            fontWeight: FontWeight.w600,
          ),
        ),
        const SpaceHeight(6),
        SizedBox(
          height: 54,
          child: DropdownButtonFormField<T>(
            validator: validator,
            items: items,
            value: value,
            hint: Text(
              label,
            ),
            menuMaxHeight: 240,
            decoration: InputDecoration(
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 20,
                maxWidth: 20,
              ),
              hintText: label,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.black,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.black,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              border: const UnderlineInputBorder(),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
