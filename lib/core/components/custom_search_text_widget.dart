import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'spaces.dart';

class CustomSearchTextWidget extends StatelessWidget {
  const CustomSearchTextWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.onFieldSubmitted,
    this.onSearch,
    this.iconSubmit,
    this.backgroundSubmit = AppColors.primary,
  });

  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onSearch;
  final Icon? iconSubmit;
  final Color? backgroundSubmit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: kTextTabBarHeight,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: TextFormField(
              controller: controller,
              onFieldSubmitted: onFieldSubmitted,
              textInputAction: TextInputAction.search,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              // onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primary,
                ),
                contentPadding: const EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
              ),
            ),
          ),
        ),
        const SpaceWidth(14),
        InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onSearch,
          child: Container(
            height: kTextTabBarHeight,
            width: kTextTabBarHeight,
            decoration: BoxDecoration(
              color: backgroundSubmit,
              borderRadius: BorderRadius.circular(18),
            ),
            child: iconSubmit,
          ),
        ),
      ],
    );
  }
}
