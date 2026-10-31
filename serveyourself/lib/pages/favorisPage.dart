import 'package:flutter/material.dart';
import 'package:serveyourself/api/meal_api.dart';
import 'package:serveyourself/models/meal.dart';
import 'package:serveyourself/services/meal_service.dart';
import 'package:serveyourself/services/userInfo_service.dart';
import '../components/navBar.dart';
import '../components/card.dart';
import '../pages/EntreeFavorisPage.dart';
import '../pages/PlatFavorisPage.dart';
import '../pages/DessertFavorisPage.dart';
import '../pages/AutreFavorisPage.dart';
import '../models/favorite_item.dart';
import 'package:provider/provider.dart';
import '../stateManagement/recipeBloc/favorites_provider.dart';
import '../models/RecipeItem.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Meal> favMeals = [];

  void getMeals() async {
    List<String> favIds = await MealService.getAllFavouriteMealsIDS(
        UserInfoService.getUserId() ?? "0");

    List<Meal> meals = await MealApi().fetchMealsByIds(favIds);
    favMeals = [];
    favMeals.addAll(meals);
    favMeals.shuffle();
  }

  Map<String, List<FavoriteItem>> favoriteCategories = {
    "Entrée": [
      FavoriteItem(
          title: "Oeufs mimosa",
          imageUrl: "https://via.placeholder.com/100",
          rating: 4.7),
      FavoriteItem(
          title: "Salade César",
          imageUrl: "https://via.placeholder.com/100",
          rating: 4.5),
    ],
    "Plat": [
      FavoriteItem(
          title: "Carbonara",
          imageUrl: "https://via.placeholder.com/100",
          rating: 4.5),
      FavoriteItem(
          title: "Lasagnes",
          imageUrl: "https://via.placeholder.com/100",
          rating: 4.6),
    ],
    "Dessert": [
      FavoriteItem(
          title: "Cheesecake",
          imageUrl: "https://via.placeholder.com/100",
          rating: 4.8),
      FavoriteItem(
          title: "Tiramisu",
          imageUrl: "https://via.placeholder.com/100",
          rating: 4.9),
    ],
    "Autre": [
      FavoriteItem(
          title: "Boissons",
          imageUrl: "https://via.placeholder.com/100",
          rating: 4.3),
    ],
  };

  Map<String, List<FavoriteItem>> filteredCategories = {};

  @override
  void initState() {
    super.initState();
    filteredCategories = Map.from(favoriteCategories);
    _searchController.addListener(_filterFavorites);
  }

  void _filterFavorites() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredCategories = Map.from(favoriteCategories);
      } else {
        filteredCategories = {};
        favoriteCategories.forEach((category, items) {
          List<FavoriteItem> filteredItems = items
              .where((item) => item.title.toLowerCase().contains(query))
              .toList();
          if (filteredItems.isNotEmpty) {
            filteredCategories[category] = filteredItems;
          }
        });
      }
    });
  }

  void _removeFromFavorites(FavoriteItem item) {
    setState(() {
      favoriteCategories.forEach((category, items) {
        items.removeWhere((favItem) => favItem.title == item.title);
      });
      _filterFavorites();
    });
  }

  void _navigateToCategoryPage(String category, List<FavoriteItem> items) {
    Widget page;
    switch (category) {
      case "Entrée":
        page = EntreeFavorisPage(entrees: items);
        break;
      case "Plat":
        page = PlatFavorisPage(plats: items);
        break;
      case "Dessert":
        page = DessertFavorisPage(desserts: items);
        break;
      case "Autre":
        page = AutreFavorisPage(autres: items);
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    var favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoris",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Rechercher dans vos recettes favorites",
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: filteredCategories.isEmpty
                ? const Center(child: Text("Aucune recette trouvée"))
                : ListView(
                    children: filteredCategories.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(entry.key,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                GestureDetector(
                                  onTap: () => _navigateToCategoryPage(
                                      entry.key, entry.value),
                                  child: const Icon(Icons.arrow_forward_ios,
                                      size: 20, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 176,
                            child: Consumer<FavoritesProvider>(
                              builder: (context, favoritesProvider, child) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: favMeals.length,
                                  itemBuilder: (context, index) {
                                    final recipe = favMeals[index];
                                    print("\n fav meal ${recipe.strMeal}");
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: FavoriteCard(
                                        title: recipe.strMeal,
                                        imageUrl: recipe.strMealThumb,
                                        rating: 3,
                                        isFavorite: true,
                                        onToggleFavorite: () {
                                          /*  favoritesProvider
                                              .toggleFavorite(recipe); */
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
