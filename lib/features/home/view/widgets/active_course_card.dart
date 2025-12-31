import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leraner/app/core/constants/app_colors.dart';
import 'package:leraner/features/home/controller/home_controller.dart';


class ActiveCourseCard extends StatelessWidget {
  const ActiveCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final home = controller.homeData.value;
      if (home == null) return const SizedBox();

      final course = home.activeCourse;

      return Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          height: 104.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF355C8C),
                Color(0xFF3F51D7),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60.h,
                    height: 60.h,
                    child: CircularProgressIndicator(
                      value: course.progress / 100,
                      strokeWidth: 8,
                      backgroundColor: Colors.white,
                      valueColor: const AlwaysStoppedAnimation(Colors.amber),
                    ),
                  ),
                  Text(
                    "${course.progress.toInt()}%",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              /// 🔹 COURSE DETAILS
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: TextStyle(
                        color: AppColors.ktextWhite,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 14, color: Colors.amber),
                        const SizedBox(width: 5),
                        Text(
                          "${course.testsCompleted}/${course.totalTests} Tests",
                          style: TextStyle(
                            color: AppColors.ktextWhite,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    /// 🔹 ACTION BUTTONS
                    Row(
                      children: [
                        _ActionButton(
                          label: "Continue >>>",
                          onTap: (){

                          },
                        ),
                         SizedBox(width: 8),
                        _ActionButton(
                          label: "Shift Course",
                          onTap:  (){

                          },
                          light: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool light;

  const _ActionButton({
    required this.label,
    required this.onTap,
    this.light = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: AppColors.kprimary,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Text(
          label,
          style:  TextStyle(
            color: AppColors.ktextWhite,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}



