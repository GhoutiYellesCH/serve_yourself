import 'package:flutter/material.dart';
import '../components/card.dart';
import '../models/favorite_item.dart';

class EntreeFavorisPage extends StatefulWidget {
  final List<FavoriteItem> entrees;

  const EntreeFavorisPage({super.key, required this.entrees});

  @override
  _EntreeFavorisPageState createState() => _EntreeFavorisPageState();
}

class _EntreeFavorisPageState extends State<EntreeFavorisPage> {
  late List<FavoriteItem> favoriteEntrees;

  @override
  void initState() {
    super.initState();
    favoriteEntrees = List.from(widget.entrees);
  }

  void _removeFromFavorites(FavoriteItem item) {
    setState(() {
      favoriteEntrees.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrées Favorites"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: favoriteEntrees.isEmpty
          ? const Center(child: Text("Aucune entrée favorite"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Deux colonnes
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85, // Ajuste la taille des cartes
              ),
              itemCount: favoriteEntrees.length,
              itemBuilder: (context, index) {
                final item = favoriteEntrees[index];
                return FavoriteCard(
                  title: item.title,
                  imageUrl: item.imageUrl,
                  rating: item.rating,
                  isFavorite: true,
                  onToggleFavorite: () => _removeFromFavorites(item),
                );
              },
            ),
    );
  }
}
