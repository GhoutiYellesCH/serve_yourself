import 'package:flutter/material.dart';

class IngredientList extends StatelessWidget {
  final List<String> ingredients;

  IngredientList({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(ingredients[index]));
      },
    );
  }
}
