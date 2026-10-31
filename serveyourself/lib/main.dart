import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: depend_on_referenced_packages

import 'package:provider/provider.dart';
import 'package:serveyourself/helpers/design.dart';
import 'package:serveyourself/helpers/routes.dart';
import 'package:serveyourself/pages/CalendarPage.dart';
import 'package:serveyourself/pages/MainLayout.dart';
import 'package:serveyourself/pages/loginPage.dart';
import 'package:serveyourself/pages/mealPage/meal_page_view.dart';
import 'package:serveyourself/pages/randomMealPage.dart';
import 'package:serveyourself/pages/searchMeal/search_meal_view.dart';
import 'package:serveyourself/pages/signupPage.dart';
import 'package:serveyourself/pages/test.dart';
import 'package:serveyourself/pages/favorisPage.dart'; 
import './stateManagement/recipeBloc/favorites_provider.dart';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


final GoRouter _router = GoRouter(
  // ignore: prefer_interpolation_to_compose_strings
  initialLocation: '/' + Routes.routeLogin,
  routes: [
    GoRoute(
      path: '/test',
      name: '/test',
      builder: (context, state) => Test(),
    ),
    GoRoute(
      // ignore: prefer_interpolation_to_compose_strings
      path: '/' + Routes.routeHome,
      name: Routes.routeHome,
      builder: (context, state) => MainLayout(),
    ),
    GoRoute(
      path: '/${Routes.routeLogin}',
      name: Routes.routeLogin,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/${Routes.routeSignUp}',
      name: Routes.routeSignUp,
      builder: (context, state) => SignupPage(),
    ),
    GoRoute(
      path: '/${Routes.routeFavoris}',
      name: Routes.routeFavoris,
      builder: (context, state) => FavoritesPage(),
    ),
    GoRoute(
      path: '/${Routes.routeCalendar}',
      name: Routes.routeCalendar,
      builder: (context, state) => CalendarPage(),
    ),
    GoRoute(
      path: '/${Routes.routeRandomMeal}',
      name: Routes.routeRandomMeal,
      builder: (context, state) => RandomMealpage(),
    ),
    GoRoute(
      path: '/${Routes.routeMealPage}',
      name: Routes.routeMealPage,
      builder: (context, state) {
         final args = state.extra as Map<String, dynamic>;
    final title = args['title'];
    final imgUrl = args['imgUrl'];
    return MealPageView(title: title, imgUrl: imgUrl);
      },
    ),
      GoRoute(
      path: '/${Routes.routeSearchCategory}',
      name: Routes.routeSearchCategory,
      builder: (context, state) => SearchMealPage(allMeals: [],),
    ),
  ],
);


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme : lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, 
      title: 'ServeYourself',
     
      routerConfig: _router,
    );
  }
}
