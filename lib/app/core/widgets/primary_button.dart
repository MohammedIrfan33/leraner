import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leraner/app/core/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final Color? backgroundColor;
  final double ? fontSize;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.height,
    this.backgroundColor,
    this.fontSize
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 45.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.kprimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.r),
          ),
          elevation: 0,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize?? 17.sp,
            color: AppColors.ktextWhite,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
