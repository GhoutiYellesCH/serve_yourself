import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:serveyourself/components/mealCard.dart';
import 'package:serveyourself/helpers/routes.dart';
import 'package:serveyourself/models/meal.dart';






const String jsonString = '''
{
  "meals":[
    {
      "idMeal":"52771",
      "strMeal":"Spicy Arrabiata Penne",
      "strMealAlternate":null,
      "strCategory":"Vegetarian",
      "strArea":"Italian",
      "strInstructions":"Bring a large pot of water to a boil. Add kosher salt to the boiling water, then add the pasta...",

      "strMealThumb":"https://www.themealdb.com/svgs/media/meals/ustsqw1468250014.jpg",

      "strTags":"Pasta,Curry",
      "strYoutube":"https://www.youtube.com/watch?v=1IszT_guI08",
      "strIngredient1":"penne rigate",
      "strIngredient2":"olive oil",
      "strIngredient3":"garlic",
      "strIngredient4":"chopped tomatoes",
      "strIngredient5":"red chilli flakes",
      "strIngredient6":"italian seasoning",
      "strIngredient7":"basil",
      "strIngredient8":"Parmigiano-Reggiano",
      "strIngredient9":"",
      "strIngredient10":"",
      "strIngredient11":"",
      "strIngredient12":"",
      "strIngredient13":"",
      "strIngredient14":"",
      "strIngredient15":"",
      "strIngredient16":null,
      "strIngredient17":null,
      "strIngredient18":null,
      "strIngredient19":null,
      "strIngredient20":null,
      "strMeasure1":"1 pound",
      "strMeasure2":"1/4 cup",
      "strMeasure3":"3 cloves",
      "strMeasure4":"1 tin ",
      "strMeasure5":"1/2 teaspoon",
      "strMeasure6":"1/2 teaspoon",
      "strMeasure7":"6 leaves",
      "strMeasure8":"sprinkling",
      "strMeasure9":"",
      "strMeasure10":"",
      "strMeasure11":"",
      "strMeasure12":"",
      "strMeasure13":"",
      "strMeasure14":"",
      "strMeasure15":"",
      "strMeasure16":null,
      "strMeasure17":null,
      "strMeasure18":null,
      "strMeasure19":null,
      "strMeasure20":null,
      "strSource":null,
      "strImageSource":null,
      "strCreativeCommonsConfirmed":null,
      "dateModified":null
    }
  ]
}
''';





class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    
      final Map<String, dynamic> decodedJson = jsonDecode(jsonString);
      final Meal meal = Meal.fromJson(decodedJson['meals'][0]);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Calendar"),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.menu),
          ),],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           
            Container(
              height:  MediaQuery.of(context).size.height * 0.3,
              child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2026, 4, 21),
              onDateChanged: (DateTime date) {
                // Do something with the selected date
              },
            ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                itemCount: 2,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                return MealCard(meal: meal);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
