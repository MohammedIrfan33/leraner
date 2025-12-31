import 'package:get/get.dart';
import 'package:leraner/app/core/model/user_model.dart';
import 'package:leraner/services/api_services.dart';


class HomeController extends GetxController {
  final ApiService apiService = ApiService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var userData = Rxn<UserModel>();

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  void fetchUserData() async {
    try {
      isLoading(true);
      errorMessage('');
      final data = await apiService.fetchHomeData();
      userData.value = UserModel.fromJson(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  /// Retry API call
  void retry() {
    fetchUserData();
  }
}
