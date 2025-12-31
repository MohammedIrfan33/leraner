import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leraner/app/core/constants/app_colors.dart';
import 'package:leraner/features/home/view/widgets/active_course_card.dart';
import 'package:leraner/features/home/view/widgets/community_card.dart';
import 'package:leraner/features/home/view/widgets/home_hero_slider.dart';
import 'package:leraner/features/home/view/widgets/live_card.dart';
import 'package:leraner/features/home/view/widgets/popular_course.dart';
import 'package:leraner/features/home/view/widgets/support_section.dart';
import 'package:leraner/features/home/view/widgets/testmonial_section.dart';
import '../controller/home_controller.dart';
import '../../../app/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  double topHeight = 212.h;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.retry,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        final home = controller.homeData.value;
        if (home == null) {
          return const Center(child: Text("No data available"));
        }

        return SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: topHeight,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/home-bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    HomeHeroSlider(),

                    Positioned(
                      top: 50.h,
                      left: 30.h,
                      right: 30.h,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              home.user.greeting,
                              style: TextStyle(
                                color: AppColors.ktextWhite,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.streak);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                "Day ${home.user.streakDays} 🔥",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.notifications, size: 15),
                            radius: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 80.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Active Courses",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ),

                SizedBox(height: 10.h),
                ActiveCourseCard(),
                SizedBox(height: 30.h),
                PopularCoursesSection(),

                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LiveClassCard(
                    title: home.liveSession.title,
                    instructor: home.liveSession.instructor,
                    time: home.liveSession.date + home.liveSession.time,
                    action: home.liveSession.action,

                    isLive: home.liveSession.isLive,

                    onJoin: () {
                      // join live class
                    },
                  ),
                ),

                SizedBox(height: 25.h),

                CommunityCard(onTap: () {}, community: home.community),

                SizedBox(height: 25.h),
                TestimonialSection(),
                SupportSection(
                  support: controller.homeData.value!.support,
                  onChatTap: () {
                    
                  },
                  onCallTap: () {
                    
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
