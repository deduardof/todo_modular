import 'package:flutter/material.dart';
import 'package:todo_modular/src/core/colors/app_colors.dart';

final inputDecorationTheme = InputDecorationTheme(
  fillColor: AppColors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: AppColors.lightGrey,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: AppColors.lightGrey,
    ),
  ),
);
