import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leraner/app/core/constants/app_colors.dart';
import 'package:leraner/app/core/model/home_model.dart';
import 'package:leraner/app/core/widgets/primary_button.dart';
import 'package:leraner/features/home/controller/home_controller.dart';

class PopularCoursesSection extends StatelessWidget {
  const PopularCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final selectedIndex = 0.obs;

    return Obx(() {
      final home = controller.homeData.value;

      if (home == null || home.popularCourses.isEmpty) {
        return const SizedBox();
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 TITLE ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular Courses",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "View all",
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 20,
                children: List.generate(home.popularCourses.length, (index) {
                  final category = home.popularCourses[index];
                  final isSelected = selectedIndex.value == index;

                  return _PopularChip(
                    title: category.name,
                    isSelected: isSelected,
                    onTap: () {
                      selectedIndex.value = index;
                    },
                  );
                }),
              ),
            ),

            SizedBox(height: 20.h),

            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: home.popularCourses.first.courses.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final course = home.popularCourses.first.courses[index];

                return _PopularCourseCard(course: course);
              },
            ),
          ],
        ),
      );
    });
  }
}

class _PopularChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _PopularChip({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kprimary : AppColors.kSecondary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.ktextWhite : AppColors.kprimary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _PopularCourseCard extends StatelessWidget {
  final Course course;

  const _PopularCourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 157,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          /// 🔹 Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              course.image,
              width: 157.w,
              height: 101.h,

              fit: BoxFit.fitWidth,
            ),
          ),

          /// 🔹 Bottom content
          Positioned(
            left: 8.w,
            right: 8.w,
            bottom: 8.h,
            child: Container(
              height: 72.h,
              width: 142.w,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      course.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: PrimaryButton(
                      height: 24.h,
                      title: "Explore More",
                      fontSize: 10.sp,
                      onPressed: () {
                        // navigate
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
