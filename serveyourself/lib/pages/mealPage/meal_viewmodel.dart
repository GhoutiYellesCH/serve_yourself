import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../models/meal.dart';

class MealViewModel extends BaseViewModel implements InputsMealView , OutputsMealView{
  final BehaviorSubject<List<Meal>> _streamController = BehaviorSubject();
  List<Meal> mealList = [];
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void fetchMeals() async {
    _streamController.add([]); // Send an empty list to indicate loading
    final data = [
      Meal(
        idMeal: "52811",
        strMeal: "Beef Bourguignon",
        strCategory: "Beef",
        strArea: "French",
        strInstructions: "Heat the oil in a large ovenproof casserole dish or heavy-based pan over a medium heat...",
        strMealThumb: "https://www.themealdb.com/svgs/media/meals/vtqxtw1511731941.jpg",
        ingredients: ["Beef", "Bacon", "Onion", "Carrots", "Garlic", "Tomato Puree", "Red Wine", "Beef Stock", "Mushrooms", "Thyme", "Bay Leaf"],
        measures: ["1kg", "200g", "2", "2", "4 cloves", "2 tbsp", "750ml", "500ml", "250g", "Several sprigs", "2"],
      ),
      Meal(
        idMeal: "52971",
        strMeal: "Thai Green Curry",
        strCategory: "Chicken",
        strArea: "Thai",
        strInstructions: "Heat the oil in a wok or large pan over a medium heat...",
        strMealThumb: "https://www.themealdb.com/svgs/media/meals/vss71q1618488984.jpg",
        ingredients: ["Chicken", "Green Curry Paste", "Coconut Milk", "Vegetables (e.g., broccoli, bell peppers)", "Fish Sauce", "Sugar", "Lime Leaves", "Holy Basil"],
        measures: ["500g", "2 tbsp", "400ml", "200g", "1 tbsp", "1 tsp", "2", "A handful"],
      ),
      Meal(
        idMeal: "52776",
        strMeal: "Spaghetti Bolognese",
        strCategory: "Beef",
        strArea: "Italian",
        strInstructions: "Heat the olive oil in a large pan over a medium heat...",
        strMealThumb: "https://www.themealdb.com/svgs/media/meals/sypxpx1515365095.jpg",
        ingredients: ["Ground Beef", "Onion", "Carrots", "Celery", "Garlic", "Canned Tomatoes", "Beef Stock", "Red Wine", "Bay Leaf", "Spaghetti"],
        measures: ["500g", "1", "1", "1 stick", "2 cloves", "400g", "250ml", "150ml", "1", "500g"],
      ),
    ];
    mealList.clear();
    mealList.addAll(data);
    await Future.delayed(Duration(seconds: 2));
    addMeals.add(data); // Send meals to the stream
  }


  @override
  void fetchMealsByCategory(String category) {
    // TODO: implement fetchMealsByCategory
  }

  @override
  Sink<List<Meal>> get addMeals => _streamController.sink;

  @override
  void search(String query) {
    // TODO: implement search
  }

  @override
  // TODO: implement searchStream
  Stream<List<Meal>> get searchStream => throw UnimplementedError();

  @override
  void start() {
    fetchMeals();
  }

  @override
  Stream<List<Meal>> get streamMeal => _streamController.stream;
}

abstract class InputsMealView {
Sink <List<Meal>> get addMeals;
}
abstract class OutputsMealView {
  Stream<List<Meal>> get streamMeal;
  Stream<List<Meal>> get searchStream;
  void search(String query);
  void fetchMeals();
  void fetchMealsByCategory(String category);

}



abstract class BaseViewModel {
  void start() ;
  void dispose() ;
}
