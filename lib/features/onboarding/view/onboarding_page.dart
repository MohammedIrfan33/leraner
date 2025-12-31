import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leraner/features/onboarding/controller/onboard_controller.dart';


class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final controller = Get.put(OnboardingController());

  final pages = const [
    {
      "title": "Smarter Learning Starts Here",
      "description": "Build skills with structured and guided learning."
    },
    {
      "title": "Learn. Practice. Succeed.",
      "description": "Practice daily and achieve your learning goals."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final page = pages[controller.pageIndex.value];

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              /// Image placeholder
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey.shade300,
                child: const Center(child: Text("Image")),
              ),

              const SizedBox(height: 32),

              Text(
                page['title']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                page['description']!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: controller.nextPage,
                child: const Text("Next"),
              ),

              TextButton(
                onPressed: controller.skip,
                child: const Text("Skip"),
              ),
            ],
          ),
        );
      }),
    );
  }
}
