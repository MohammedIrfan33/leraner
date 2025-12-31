import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://trogon.info/task/api/';

  /// Fetch Home Data with error handling
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
}
