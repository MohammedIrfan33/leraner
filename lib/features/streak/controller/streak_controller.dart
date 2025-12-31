import 'package:get/get.dart';
import 'package:leraner/app/core/model/streak_model.dart';
import 'package:leraner/services/api_services.dart';


class StreakController extends GetxController {
  final ApiService apiService = ApiService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var streakData = Rxn<StreakModel>();

  @override
  void onInit() {
    fetchStreak();
    super.onInit();
  }

  void fetchStreak() async {
    try {
      isLoading(true);
      errorMessage('');
      streakData.value = await apiService.fetchStreakData();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  void retry() {
    fetchStreak();
  }
}
