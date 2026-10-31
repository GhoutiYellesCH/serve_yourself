import 'package:flutter/material.dart';
import 'package:serveyourself/models/meal.dart';
import 'package:url_launcher/url_launcher.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({Key? key, required this.meal}) : super(key: key);

  List<Widget> buildIngredients() {
    List<Widget> ingredientsList = [];
    for (int i = 0; i < meal.ingredients.length; i++) {
      ingredientsList.add(
        Text("• ${meal.measures[i]} ${meal.ingredients[i]}"),
      );
    }
    return ingredientsList;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Meal Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              meal.strMealThumb,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),

          // Title and Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.strMeal,
                ),
                const SizedBox(height: 4),
                Text(
                  '${meal.strCategory} • ${meal.strArea}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),

                // Ingredients
                Text(
                  "Ingredients:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...buildIngredients(),

                const SizedBox(height: 12),

                // Instructions
                Text(
                  "Instructions:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(meal.strInstructions),

                const SizedBox(height: 12),

                // YouTube Button
                if ((meal.strYoutube ?? '').isNotEmpty)
                  ElevatedButton.icon(
                    onPressed: () {
                      final Uri _url =
                          Uri.parse(meal.strYoutube ?? "youtube.com");
                      Future<bool> can = canLaunch(_url.toString());
                      can.then((value) {
                        launchUrl(_url);
                      });

                      // You can use url_launcher to launch the URL
                    },
                    icon: const Icon(Icons.play_circle_filled),
                    label: const Text('Watch on YouTube'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
