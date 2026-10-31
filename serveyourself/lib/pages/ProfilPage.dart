import 'package:flutter/material.dart';
import '../components/card.dart';

class User {
  final String name;
  final String profileImage;
  final String role;
  final List<String> favoriteRecipes;
  final List<String> notes;
  final List<String> publishedRecipes;
  final List<String> userImages;
  final List<String> userComments;

  User({
    required this.name,
    required this.profileImage,
    required this.role,
    required this.favoriteRecipes,
    required this.notes,
    required this.publishedRecipes,
    required this.userImages,
    required this.userComments,
  });
}

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final User currentUser = User(
    name: "Mohamed Mbarak",
    profileImage: "https://via.placeholder.com/100",
    role: "Membre du Serve Yourself",
    favoriteRecipes: ["Oeufs mimosa", "Cheese Cake", "Tiramisu"],
    notes: ["Pâtes Carbonara", "Gâteau au chocolat", "Pizza maison"],
    publishedRecipes: ["Couscous", "Tajine de poulet", "Chorba"],
    userImages: List.generate(6, (index) => "https://via.placeholder.com/150"),
    userComments: List.generate(3, (index) => "Je suis très heureux d’avoir cette recette"),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Navigator.canPop(context)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                )
              : null, // لا تعرض زر الرجوع إذا لم يكن هناك سجل تنقل
          title: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(currentUser.profileImage),
              ),
              const SizedBox(height: 5),
              Text(
                currentUser.name,
                style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                currentUser.role,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: "RECETTES"),
              Tab(text: "IMAGES"),
              Tab(text: "COMMENTAIRES"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildRecettesTab(),
            _buildImagesTab(),
            _buildCommentairesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecettesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Mes favoris", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildHorizontalList(currentUser.favoriteRecipes),

          const SizedBox(height: 10),
          const Text("Mes Notes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildHorizontalList(currentUser.notes),

          const SizedBox(height: 10),
          const Text("Mes recettes publiées", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          _buildHorizontalList(currentUser.publishedRecipes),
        ],
      ),
    );
  }

  Widget _buildImagesTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: currentUser.userImages.length,
      itemBuilder: (context, index) {
        return Image.network(currentUser.userImages[index], fit: BoxFit.cover);
      },
    );
  }

  Widget _buildCommentairesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: currentUser.userComments.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Image.network("https://via.placeholder.com/80", fit: BoxFit.cover),
            title: const Text("Cheese cake", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(currentUser.userComments[index]),
          ),
        );
      },
    );
  }

  Widget _buildHorizontalList(List<String> items) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FavoriteCard(
              title: items[index],
              imageUrl: "https://via.placeholder.com/100",
              rating: 4.7,
              isFavorite: true,
              onToggleFavorite: () => print("Remove from favorites"),
            ),
          );
        },
      ),
    );
  }
}
