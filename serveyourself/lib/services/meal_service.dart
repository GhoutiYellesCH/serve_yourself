import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:serveyourself/api/meal_api.dart';
import 'package:serveyourself/helpers/firebaseCollections.dart';
import 'package:serveyourself/models/meal.dart';

class MealService {
  static final MealApi mealApi = MealApi();
  static final db = FirebaseFirestore.instance;
  static final Dio _dio = Dio();
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

/*   static Future<List<Meal>> getMeals() async {
    final mealsJson = await mealApi.fetchMeals();
    return mealsJson.map((json) => Meal.fromJson(json)).toList();
  } */

  // -- managing favourites on firebase :
  static Future<List<String>> getAllFavouriteMealsIDS(String userId) async {
    final snapshot = await db
        .collection(FirebaseCollections.users)
        .doc(userId)
        .collection(FirebaseCollections.favourites)
        .get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }

  static Future<void> addToFavourite(String userId, String mealId) async {
    await db
        .collection(FirebaseCollections.users)
        .doc(userId)
        .collection(FirebaseCollections.favourites)
        .doc(mealId)
        .set({'addedAt': FieldValue.serverTimestamp()});
  }

  static Future<void> removeFromFavourite(String userId, String mealId) async {
    await db
        .collection(FirebaseCollections.users)
        .doc(userId)
        .collection(FirebaseCollections.favourites)
        .doc(mealId)
        .delete();
  }

  // -- managing calendar :
  static Future<List<String>> getAllDayCalendarMeals(String userId) async {
    final snapshot = await db
        .collection(FirebaseCollections.users)
        .doc(userId)
        .collection(FirebaseCollections.calendar)
        .get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }

  static Future<void> addToCalendar(String userId, String mealId) async {
    await db
        .collection(FirebaseCollections.users)
        .doc(userId)
        .collection(FirebaseCollections.calendar)
        .doc(mealId)
        .set({'addedAt': FieldValue.serverTimestamp()});
  }

  static Future<void> removeFromCalendar(String userId, String mealId) async {
    await db
        .collection(FirebaseCollections.users)
        .doc(userId)
        .collection(FirebaseCollections.calendar)
        .doc(mealId)
        .delete();
  }

  static Future<List<Meal>> fetchMealsByIds(List<String> mealIds) async {
    List<Meal> meals = [];

    for (String id in mealIds) {
      try {
        final response =
            await _dio.get('$_baseUrl/lookup.php', queryParameters: {
          'i': id,
        });

        if (response.statusCode == 200) {
          final mealJson = response.data['meals'];
          if (mealJson != null && mealJson.isNotEmpty) {
            meals.add(Meal.fromJson(mealJson[0]));
          }
        }
      } catch (e) {
        print('Error fetching meal with ID $id: $e');
      }
    }

    return meals;
  }
}
