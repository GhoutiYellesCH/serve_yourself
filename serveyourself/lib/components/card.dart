import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serveyourself/helpers/routes.dart';

class FavoriteCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double rating;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final String? idMeal;

  const FavoriteCard({
    super.key,
    this.idMeal,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
  Routes.routeMealPage,
  extra: {
    "title": title,
    "imgUrl": imageUrl,
  },
);

      },
      child: Container(
        width: 152,
        height: 176,
        decoration: BoxDecoration(
          color: const Color(0xFFFFEED2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFF5F00), width: 3),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image,
                        size: 100, color: Color(0xFFFFCB84));
                  },
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () {
                  onToggleFavorite();
                  print("tap fav");
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                  size: 24,
                ),
              ),
            ),
            const Positioned(
              top: 5,
              left: 5,
              child: Icon(Icons.add_circle, color: Colors.white, size: 24),
            ),
            Positioned(
              bottom: 30,
              left: 10,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Row(
                children: List.generate(5, (starIndex) {
                  return Icon(
                    starIndex < rating.round() ? Icons.star : Icons.star_border,
                    color: const Color(0xFFFF5F00),
                    size: 16,
                  );
                }),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Text(
                rating.toString(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
