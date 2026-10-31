import 'package:flutter/material.dart';
import '../components/card.dart';
import '../models/favorite_item.dart';

class AutreFavorisPage extends StatefulWidget {
  final List<FavoriteItem> autres;

  const AutreFavorisPage({super.key, required this.autres});

  @override
  _AutreFavorisPageState createState() => _AutreFavorisPageState();
}

class _AutreFavorisPageState extends State<AutreFavorisPage> {
  late List<FavoriteItem> favoriteAutres;

  @override
  void initState() {
    super.initState();
    favoriteAutres = List.from(widget.autres);
  }

  void _removeFromFavorites(FavoriteItem item) {
    setState(() {
      favoriteAutres.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Autres Favoris"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: favoriteAutres.isEmpty
          ? const Center(child: Text("Aucun autre favori"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemCount: favoriteAutres.length,
              itemBuilder: (context, index) {
                final item = favoriteAutres[index];
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
