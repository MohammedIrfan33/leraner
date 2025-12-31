import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leraner/app/core/model/home_model.dart';
import 'package:leraner/features/home/controller/home_controller.dart';

class HomeHeroSlider extends StatefulWidget {
  const HomeHeroSlider({super.key});

  @override
  State<HomeHeroSlider> createState() => _HomeHeroSliderState();
}

class _HomeHeroSliderState extends State<HomeHeroSlider> {
  final PageController _pageController = PageController(viewportFraction: 0.94);

  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController.hasClients) {
        final controller = Get.find<HomeController>();
        final banners = controller.homeData.value!.heroBanners
            .where((e) => e.isActive)
            .toList();

        if (banners.isEmpty) return;

        _currentIndex = (_currentIndex + 1) % banners.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<HomeController>();

      final activeBanners = controller.homeData.value!.heroBanners
          .where((e) => e.isActive)
          .toList();

      if (activeBanners.isEmpty) {
        return const SizedBox();
      }

      return Positioned(
        top: 120.h,
        left: 0,
        right: 0,
        child: Column(
          children: [
            /// 🔹 SLIDER
            SizedBox(
              height: 141.h,
              width: 350.w,
              child: PageView.builder(
                controller: _pageController,
                itemCount: activeBanners.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return Container(

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(activeBanners[index].image),
                        fit: BoxFit.fill
                        ),
                      borderRadius: BorderRadius.circular(15.r)
                    ),
                    
                    
                    
                  );
                },
              ),
            ),

            SizedBox(height: 10.h),

            /// 🔹 INDICATOR (like uploaded image)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                activeBanners.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 22 : 8,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Colors.amber
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
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
