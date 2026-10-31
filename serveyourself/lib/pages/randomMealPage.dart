import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serveyourself/components/mealCard.dart';
import 'package:serveyourself/models/meal.dart';

class RandomMealpage extends StatefulWidget {
  const RandomMealpage({super.key});

  @override
  State<RandomMealpage> createState() => _RandomMealpageState();
}

class _RandomMealpageState extends State<RandomMealpage> {
  List<Meal> meals = [];

  Future<Meal> fetchRandomMeal() async {
    Dio dio = Dio();
    try {
      final response =
          await dio.get("https://www.themealdb.com/api/json/v1/1/random.php");

      if (response.statusCode == 200) {
        // Assuming the meal data is inside a list under 'meals'
        return Meal.fromJson(response.data['meals'][0]);
      } else {
        throw Exception('Failed to load meal');
      }
    } catch (e) {
      throw Exception('Error fetching meal: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Random Meal"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          )),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  itemCount: meals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MealCard(meal: meals[index]);
                  }),
            )
          ],
        ),
      ),
      floatingActionButton:Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           IconButton(
          onPressed: () {
            Future<Meal> meal = fetchRandomMeal();
            meal.then(
              (value) {
                setState(() {
                
                  meals.clear();
                });
              },
            );
          },
          icon: Icon(Icons.delete)),
        
          
          IconButton(
          onPressed: () {
            Future<Meal> meal = fetchRandomMeal();
            meal.then(
              (value) {
                setState(() {
                  print(meal);
                  meals.add(value);
                });
              },
            );
          },
          icon: Icon(Icons.casino)),
        ]
      ) 
    );
  }
}
