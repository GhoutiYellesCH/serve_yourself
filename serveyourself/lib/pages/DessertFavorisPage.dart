import 'package:flutter/material.dart';
import '../components/card.dart';
import '../models/favorite_item.dart';

class DessertFavorisPage extends StatefulWidget {
  final List<FavoriteItem> desserts;

  const DessertFavorisPage({super.key, required this.desserts});

  @override
  _DessertFavorisPageState createState() => _DessertFavorisPageState();
}

class _DessertFavorisPageState extends State<DessertFavorisPage> {
  late List<FavoriteItem> favoriteDesserts;

  @override
  void initState() {
    super.initState();
    favoriteDesserts = List.from(widget.desserts);
  }

  void _removeFromFavorites(FavoriteItem item) {
    setState(() {
      favoriteDesserts.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Desserts Favoris"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: favoriteDesserts.isEmpty
          ? const Center(child: Text("Aucun dessert favori"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemCount: favoriteDesserts.length,
              itemBuilder: (context, index) {
                final item = favoriteDesserts[index];
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
