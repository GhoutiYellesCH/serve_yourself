import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serveyourself/helpers/routes.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
            child: Text("Temporary Page", style: TextStyle(fontSize: 20)),
          ),
          Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed(Routes.routeLogin);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
                  child: const Text("Login"),
                ),
                const SizedBox(height: 20), // Espace entre les boutons
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed(Routes.routeFavoris);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                  child: const Text("Aller aux Favoris"),
                ),
                
                const SizedBox(height: 20), // Espace entre les boutons
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed(Routes.routeProfil);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                  child: const Text("Aller aux profil"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
