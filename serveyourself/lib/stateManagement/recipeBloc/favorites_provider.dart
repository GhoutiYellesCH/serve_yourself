import 'package:flutter/material.dart';
import 'package:serveyourself/models/RecipeItem.dart'; 

class FavoritesProvider with ChangeNotifier {
  final List<RecipeItem> _favorites = [];

  List<RecipeItem> get favorites => _favorites;

  void toggleFavorite(RecipeItem recipe) {
    if (_favorites.any((fav) => fav.title == recipe.title)) {
      _favorites.removeWhere((fav) => fav.title == recipe.title);
    } else {
      _favorites.add(recipe);
    }
    notifyListeners();
  }

  bool isFavorite(RecipeItem recipe) {
    return _favorites.any((fav) => fav.title == recipe.title);
  }
}
