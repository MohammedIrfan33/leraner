import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:leraner/app/core/model/streak_model.dart';
import 'package:leraner/app/core/model/video_model.dart';

class ApiService {
  static const String baseUrl = 'https://trogon.info/task/api/';


  Future<Map<String, dynamic>> fetchHomeData() async {
    final url = Uri.parse('${baseUrl}home.php');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data == null || data.isEmpty) {
          throw Exception('No data available');
        }
        return data;
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException {
      throw Exception('Could not find the data');
    } on FormatException {
      throw Exception('Invalid response format');
    } on TimeoutException {
      throw Exception('Request timeout. Please try again');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<SubjectVideosModel> fetchVideoDetails() async {
  final url = Uri.parse('${baseUrl}video_details.php');

  try {
    final response = await http.get(url).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return SubjectVideosModel.fromJson(jsonData['videos']);
    } else {
      throw Exception('Server Error: ${response.statusCode}');
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  } on TimeoutException {
    throw Exception('Request Timeout');
  } on FormatException {
    throw Exception('Invalid response format');
  } catch (e) {
    throw Exception('Something went wrong');
  }
}


Future<StreakModel> fetchStreakData() async {
  final url = Uri.parse('${baseUrl}streak.php');

  try {
    final response = await http.get(url).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return StreakModel.fromJson(data);
    } else {
      throw Exception('Server Error: ${response.statusCode}');
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  } on TimeoutException {
    throw Exception('Request Timeout');
  } on FormatException {
    throw Exception('Invalid response format');
  } catch (e) {
    throw Exception('Something went wrong');
  }
}


}
