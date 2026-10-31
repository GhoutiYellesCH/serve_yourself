import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  final String mealName;
  final String mealDescription;

  MealCard({required this.mealName, required this.mealDescription});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            mealName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(mealDescription),
        ],
      ),
    );
  }
}
