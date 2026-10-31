import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:serveyourself/models/meal.dart';

class MealApi {
  final String baseUrl;
  final Dio _dio;

  MealApi({
    this.baseUrl = 'https://www.themealdb.com/api/json/v1/1',
    Dio? dio,
  }) : _dio = dio ?? Dio();

  /// Check API availability
  Future<bool> isApiReachable() async {
    try {
      final response = await _dio.get(baseUrl);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  // Fetch Meals by first letter :
  Future<List<Meal>> fetchByFirstLetter(String char) async {
    List<Meal> meals = [];
    try {
      final response = await _dio.get(baseUrl + '/search.php?f=$char');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['meals'] != null && data['meals'].isNotEmpty) {
          for (var m in data['meals']) {
            meals.add(Meal.fromJson(m));
          }
        }
      }
    } catch (e) {
      print("err cannot fetch meals by letter : $e");
    }
    return meals;
  }

  /// Fetch meals by a list of meal IDs
  Future<List<Meal>> fetchMealsByIds(List<String> mealIds) async {
    List<Meal> meals = [];

    for (String id in mealIds) {
      try {
        final response =
            await _dio.get('$baseUrl/lookup.php', queryParameters: {
          'i': id,
        });

        if (response.statusCode == 200) {
          final data = response.data;
          if (data['meals'] != null && data['meals'].isNotEmpty) {
            meals.add(Meal.fromJson(data['meals'][0]));
          }
        } else {
          throw Exception('Failed to fetch meal $id: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching meal $id: $e');
      }
    }

    return meals;
  }

  /// Add a meal - placeholder for custom backend usage
  Future<Map<String, dynamic>> addMeal(Map<String, dynamic> mealData) async {
    try {
      final response = await _dio.post(
        baseUrl,
        data: mealData,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to add meal: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
