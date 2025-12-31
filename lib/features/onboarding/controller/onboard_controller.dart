import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../app/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final storage = GetStorage();

  var pageIndex = 0.obs;

  void nextPage() {
    if (pageIndex.value < 1) {
      pageIndex.value++;
    } else {
      completeOnboarding();
    }
  }

  void skip() {
    completeOnboarding();
  }

  void completeOnboarding() {
    storage.write('onboarding_done', true);
    Get.offAllNamed(AppRoutes.home);
  }
}
