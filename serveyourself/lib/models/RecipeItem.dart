class RecipeItem {
  final String title;
  final String imageUrl;
  final double rating;
  bool isFavorite;
  String? id;

  RecipeItem({
    required this.title,
    required this.imageUrl,
    required this.rating,
    this.isFavorite = false,
    this.id
  });
}
