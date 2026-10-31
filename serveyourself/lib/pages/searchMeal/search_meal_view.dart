import 'package:flutter/material.dart';
import '../../models/meal.dart';
import '../../helpers/design.dart';

class SearchMealPage extends StatefulWidget {
  final List<Meal> allMeals;

  const SearchMealPage({super.key, required this.allMeals});

  @override
  State<SearchMealPage> createState() => _SearchMealPageState();
}

class _SearchMealPageState extends State<SearchMealPage> {
  late List<Meal> filteredMeals;
  String query = '';

  @override
  void initState() {
    super.initState();
    filteredMeals = widget.allMeals;
  }

  void updateSearch(String value) {
    setState(() {
      query = value.toLowerCase();
      filteredMeals = widget.allMeals
          .where((meal) =>
      meal.strMeal.toLowerCase().contains(query) ||
          meal.strInstructions.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Meals"),
        backgroundColor: Design.primary,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: updateSearch,
              decoration: InputDecoration(
                hintText: 'Search for meals...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMeals.length,
              itemBuilder: (context, index) {
                final meal = filteredMeals[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(meal.strMealThumb),
                  ),
                  title: Text(meal.strMeal),
                  subtitle: Text(
                    meal.strInstructions,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
