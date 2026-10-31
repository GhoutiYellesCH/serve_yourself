import 'package:flutter/material.dart';
import '../components/card.dart';
import '../models/favorite_item.dart';

class PlatFavorisPage extends StatefulWidget {
  final List<FavoriteItem> plats;

  const PlatFavorisPage({super.key, required this.plats});

  @override
  _PlatFavorisPageState createState() => _PlatFavorisPageState();
}

class _PlatFavorisPageState extends State<PlatFavorisPage> {
  late List<FavoriteItem> favoritePlats;

  @override
  void initState() {
    super.initState();
    favoritePlats = List.from(widget.plats);
  }

  void _removeFromFavorites(FavoriteItem item) {
    setState(() {
      favoritePlats.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plats Favoris"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: favoritePlats.isEmpty
          ? const Center(child: Text("Aucun plat favori"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemCount: favoritePlats.length,
              itemBuilder: (context, index) {
                final item = favoritePlats[index];
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
