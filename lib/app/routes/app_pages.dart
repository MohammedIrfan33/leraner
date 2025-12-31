import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:leraner/app/routes/app_routes.dart';
import 'package:leraner/features/home/view/home_page.dart';
import 'package:leraner/features/onboarding/view/onboarding_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),
    
  ];
}
