import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leraner/app/core/model/home_model.dart';

import '../../controller/home_controller.dart';






class TestimonialSection extends StatelessWidget {
  const TestimonialSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final testimonials =
          controller.homeData.value?.testimonials ?? [];

      if (testimonials.isEmpty) {
        return const SizedBox();
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            Text(
              "What Learners Are Saying",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 12.h),

            /// 🔹 Horizontal Slider
            SizedBox(
              height: 170.h,
              child: PageView.builder(
                controller: controller.testimonialPageController,
                itemCount: testimonials.length,
                
                padEnds: false,
                physics: const BouncingScrollPhysics(),
                onPageChanged: controller.onTestimonialChanged,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: TestimonialCard(
                      testimonial: testimonials[index],
                    ),
                  );
                },
              ),
            ),

          

     
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                testimonials.length,
                
                (index) => Obx(
                  () => AnimatedContainer(
                    padding: EdgeInsets.zero,
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 6.h,
                    width: controller.currentTestimonialIndex.value == index
                        ? 20.w
                        : 6.w,
                    decoration: BoxDecoration(
                      color: controller.currentTestimonialIndex.value == index
                          ? const Color(0xff66BBC4)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}



class TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;

  const TestimonialCard({super.key, required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xff66BBC4),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(14.r),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15.r,
                backgroundImage: NetworkImage(testimonial.avatar),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.learnerName,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (_) => Icon(
                          Icons.star,
                          size: 12.sp,
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        "4.5",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),

        /// Review
        Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(14.r),
            ),
          ),
          child: Text(
            testimonial.review,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}


