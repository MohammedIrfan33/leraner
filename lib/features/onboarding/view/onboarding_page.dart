import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leraner/app/core/constants/app_colors.dart';
import 'package:leraner/app/core/widgets/primary_button.dart';
import 'package:leraner/features/onboarding/controller/onboard_controller.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final controller = Get.put(OnboardingController());

  final pages = const [
    {
      "title": "Smarter \nLearning Starts Here",
      "description":
          "Personalized lessons that adapt to \nyour pace and goals.",
      "image": "assets/on_bord1.png",
    },
    {
      "title": "Track Your Progress",
      "description": "Monitor your learning journey and\nimprove daily.",
      "image": "assets/on_bord2.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.kprimary,
      body: Obx(() {
        final page = pages[controller.pageIndex.value];

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 60.h,
              left: 0,
              right: 0,
              height: screenHeight - 350.h,
              child: Center(
                child: Image.asset(
                  page['image']!,
                  width: 335.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 350.h,
              child: Image.asset(
                'assets/bottom.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),

            Positioned(
              bottom: 320.h, // adjust to overlap
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/onbordIcon.png',
                  width: 61,
                  height: 61,
                ),
              ),
            ),

            Positioned(
              bottom: 35.h,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      page['title']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,

                        color: AppColors.ktextBlack,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      page['description']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.kSubtitileColor,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 7.w,
                          width: 7.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.pageIndex.value == index
                                ? AppColors.kprimary
                                : AppColors.kDotColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),

                    PrimaryButton(
                      title: "Next",
                      onPressed: controller.nextPage,
                    ),

                    TextButton(
                      onPressed: controller.skip,
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: AppColors.kprimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
