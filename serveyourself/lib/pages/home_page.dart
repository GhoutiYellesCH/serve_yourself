import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serveyourself/api/meal_api.dart';
import 'package:serveyourself/components/CategoryCard.dart';
import 'package:serveyourself/helpers/design.dart';
import 'package:serveyourself/helpers/help.dart';
import 'package:serveyourself/helpers/routes.dart';
import 'package:serveyourself/models/meal.dart';
import 'package:serveyourself/services/meal_service.dart';
import 'package:serveyourself/services/userInfo_service.dart';
import '../components/card.dart';
import '../models/CategoryItem.dart';
import '../models/RecipeItem.dart';
import '../stateManagement/recipeBloc/favorites_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Meal> meals = List.from([
    ExMeals.meal10,
    ExMeals.meal2,
    ExMeals.meal3,
    ExMeals.meal4,
    ExMeals.meal5,
  ]);

  void getMeals() async {
    meals += await MealApi().fetchByFirstLetter('a');
    meals += await MealApi().fetchByFirstLetter('b');
    meals += await MealApi().fetchByFirstLetter('n');
    meals += await MealApi().fetchByFirstLetter('a');
    meals.shuffle();
  }

  @override
  void initState() {
    // TODO: implement initState
    getMeals();
    super.initState();
  }

  final List<CategoryItem> categories = [
    CategoryItem(
        title: "Entrées",
        imageUrl:
            "https://th.bing.com/th/id/OIP.q3slhawUDi4yA_g1yp_K4wHaFA?w=228&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7"),
    CategoryItem(
        title: "Plats",
        imageUrl:
            "https://www.themealdb.com/images/media/meals/bc8v651619789840.jpg"),
    CategoryItem(
        title: "Desserts",
        imageUrl:
            "https://th.bing.com/th/id/OIP.DlPCq_dmSdVmzq4iTyQXngHaE8?w=930&h=620&rs=1&pid=ImgDetMain"),
    CategoryItem(
        title: "Autres",
        imageUrl:
            "https://th.bing.com/th/id/R.290f17489e2e5c5b20280b5416d747c2?rik=kem3r8sRoeyzrQ&pid=ImgRaw&r=0"),
  ];

  final List<RecipeItem> favoriteRecipes = [
    RecipeItem(
        title: "Oeufs mimosa",
        imageUrl:
            "https://th.bing.com/th/id/R.9e2377043ed46446cb11c22300d3ec4d?rik=SnXDj2kS9IBR1Q&pid=ImgRaw&r=0",
        rating: 4.7),
    RecipeItem(
        title: "Carbonara",
        imageUrl:
            "https://th.bing.com/th/id/R.083dd08ad9f9b7949dbb89747c88408b?rik=tO6dZSQ0l59sIg&pid=ImgRaw&r=0",
        rating: 4.5),
    RecipeItem(
        title: "Cheesecake",
        imageUrl:
            "https://th.bing.com/th/id/OIP.pojfdYMoEzfgAYwZ-2MXQQHaE8?rs=1&pid=ImgDetMain",
        rating: 4.8),
    RecipeItem(
        title: "Smoothie",
        imageUrl:
            "https://th.bing.com/th/id/OIP.6sbe9FtpMRbQv907CCuHpwHaFl?rs=1&pid=ImgDetMain",
        rating: 4.3),
  ];

  final List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  String today = DateFormat('EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var favoritesProvider = Provider.of<FavoritesProvider>(context);
    final String clientName = UserInfoService.getUserEmail() ?? "Client@a";

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Design.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person,
                                color: Colors.grey, size: 30),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello, ${clientName.split("@")[0]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text("Check Amazing Recipes..",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          context.pushNamed(Routes.routeCalendar);
                        },
                        icon: Icon(Icons.calendar_today,
                            color: Colors.white, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: "Search Any Recipe..",
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          onPressed: () {
                            context.pushNamed(Routes.routeSearchCategory);
                          },
                          icon: Icon(Icons.search, color: Design.primary),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              context.pushNamed(Routes.routeRandomMeal);
                            },
                            icon: Icon(Icons.casino)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Catégories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    title: categories[index].title,
                    imageUrl: categories[index].imageUrl,
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section "Recommended for you"
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recommended for you",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Action lorsque "See All" est cliqué
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Design.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                // Liste horizontale des recettes recommandées
                SizedBox(
                  height: 180,
                  child: Consumer<FavoritesProvider>(
                    builder: (context, favoritesProvider, child) {
                      return favoriteRecipes.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                var recipe = favoriteRecipes[index];
                                bool isFavorite =
                                    favoritesProvider.isFavorite(recipe);

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: FavoriteCard(
                                    title: recipe.title,
                                    imageUrl: recipe.imageUrl,
                                    rating: recipe.rating,
                                    isFavorite: isFavorite,
                                    onToggleFavorite: () {
                                      favoritesProvider.toggleFavorite(recipe);
                                    },
                                  ),
                                );
                              },
                            )
                          : SizedBox.shrink();
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(children: [
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: meals.length,
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var recipe = meals[index];
                        //  bool isFavorite =
                        //    favoritesProvider.isFavorite(recipe);
                        if (index > 5) {
                          return null;
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: FavoriteCard(
                            title: recipe.strMeal,
                            imageUrl: recipe.strMealThumb,
                            rating: 1,
                            isFavorite: false,
                            onToggleFavorite: () {
                              // favoritesProvider.toggleFavorite(recipe);
                            },
                          ),
                        );
                      },
                    ),
                  )
                ]),

                const SizedBox(height: 30),

                // Section "Recettes Populaires"
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recettes Populaires",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Action
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Design.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 0.01),

                // GridView des recettes populaires
                SizedBox(
                  height: 430,
                  child: Consumer<FavoritesProvider>(
                    builder: (context, favoritesProvider, child) {
                      return favoriteRecipes.isNotEmpty
                          ? GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              clipBehavior: Clip.none,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15.0,
                              ),
                              itemCount: favoriteRecipes.length,
                              itemBuilder: (context, index) {
                                var recipe = favoriteRecipes[index];
                                bool isFavorite =
                                    favoritesProvider.isFavorite(recipe);

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: FavoriteCard(
                                    title: recipe.title,
                                    imageUrl: recipe.imageUrl,
                                    rating: recipe.rating,
                                    isFavorite: isFavorite,
                                    onToggleFavorite: () {
                                      favoritesProvider.toggleFavorite(recipe);
                                    },
                                  ),
                                );
                              },
                            )
                          : SizedBox.shrink();
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 430,
                  child: GridView.builder(
                                                  physics: const NeverScrollableScrollPhysics(),
                              clipBehavior: Clip.none,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15.0,
                              ),
                              itemCount: meals.length,
       
                    itemBuilder: (context, index) {
                      var recipe = meals[index];
                      //  bool isFavorite =
                      //    favoritesProvider.isFavorite(recipe);
                     // return null;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: FavoriteCard(
                          title: recipe.strMeal,
                          imageUrl: recipe.strMealThumb,
                          rating:  Random().nextInt(5) + 0.0,
                          isFavorite: false,
                          onToggleFavorite: () {
                            // favoritesProvider.toggleFavorite(recipe);
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),

            const SizedBox(height: 40),

            // Texte Menu du jour
            Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Design.primary,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 30),
                    SizedBox(width: 8),
                    Text("Today's Menu",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
// Les jours

            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                itemBuilder: (context, index) {
                  bool isSelected =
                      days[index] == today; // هل هذا اليوم هو اليوم الحالي؟

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 110,
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [Colors.orange, Colors.deepOrange],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  Colors.grey.shade400,
                                  Colors.grey.shade600
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "https://th.bing.com/th/id/R.958dcefd50ae2ce70eab3c73cae95681?rik=WcAA%2fzMxSBcFdg&pid=ImgRaw&r=0",
                              width: 85,
                              height: 85,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            days[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
