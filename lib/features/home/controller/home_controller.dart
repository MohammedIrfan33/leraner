import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leraner/app/core/model/home_model.dart';
import 'package:leraner/services/api_services.dart';

class HomeController extends GetxController {
  final ApiService apiService = ApiService();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final homeData = Rxn<HomeModel>();

  /// 🔹 Testimonial UI state
  final PageController testimonialPageController = PageController();
  final currentTestimonialIndex = 0.obs;

  @override
  void onInit() {
    fetchHomeData();
    super.onInit();
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final Map<String, dynamic> response =
          await apiService.fetchHomeData();

      homeData.value = HomeModel.fromJson(response);
    } on SocketException {
      errorMessage.value = 'No internet connection';
    } on TimeoutException {
      errorMessage.value = 'Request timed out. Please try again';
    } on FormatException {
      errorMessage.value = 'Invalid response format';
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void onTestimonialChanged(int index) {
    currentTestimonialIndex.value = index;
  }

  /// RETRY
  void retry() {
    fetchHomeData();
  }

  @override
  void onClose() {
    testimonialPageController.dispose();
    super.onClose();
  }
}
