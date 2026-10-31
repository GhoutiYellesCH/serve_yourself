import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:serveyourself/pages/comments/comment_view.dart';
import 'package:serveyourself/pages/mealPage/meal_viewmodel.dart';

import '../../helpers/design.dart';
import '../../models/meal.dart';
import '../searchMeal/search_meal_view.dart' show SearchMealPage;

class MealPageView extends StatefulWidget {
  const MealPageView({super.key,required this.title,required this.imgUrl});
  final String title;
  final String imgUrl;

  @override
  State<MealPageView> createState() => _MealPageViewState();
}

class _MealPageViewState extends State<MealPageView> {
  final MealViewModel _mealViewModel = MealViewModel();

  @override
  void initState() {
    super.initState();
    _mealViewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //actionsPadding: EdgeInsets.symmetric(horizontal: 10),
        title: Text('Serve Yourself',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Design.primary,
        leading: Container(
          margin: EdgeInsets.only(left: 15),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
             widget.imgUrl,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    SearchMealPage(allMeals: _mealViewModel.mealList),
              ),
            ),
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
        // Match the gradient top color
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Expanded(
              child: StreamBuilder<List<Meal>>(
            stream: _mealViewModel.streamMeal,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data ?? [];
                return GestureDetector(
                  onTap: () => _mealViewModel.fetchMeals(),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 250),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return MealCard(meal: data[index]);
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      _mealViewModel.fetchMeals(); // Call your method to retry
                    },
                    child: const Text(
                      'Try again',
                      style: TextStyle(
                        color: Colors.blue,
                        // decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          )),
          CurvedHeader(title: widget.title,imgUrl: widget.imgUrl,),
        ],
      ),
    );
  }
}

class CurvedHeader extends StatefulWidget {
    const CurvedHeader({super.key,required this.title,required this.imgUrl});
  final String title;
  final String imgUrl;
  @override
  State<CurvedHeader> createState() => _CurvedHeaderState();
}

class _CurvedHeaderState extends State<CurvedHeader> {
  List<String> _comments = ["Nice!", "Tasty!", "Try this again"];



  void showCommentMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CommentScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomWaveClipper(),
      child: Stack(children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Design.primary, // Orange top
                Colors.white, // White bottom
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(
                    widget.imgUrl
                  ),
                ),
                SizedBox(height: 10),
                Text(
                   widget.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),

                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                    ),
                    IconButton(
                      icon: Icon(Icons.mode_comment_outlined),
                      onPressed: () {
                        showCommentMenu(context);
                      },
                    ),
                    Icon(Icons.bubble_chart_outlined)
                  ],
                ),
                // Spacer(flex: 1,),
              ],
            ),
          ),
        ),
        Align(
          heightFactor: 5,
          widthFactor: 5,
          child: SvgPicture.asset(
            "./assets/svgs/star.svg",
            color: Colors.white,
            width: 30,
            height: 30,
            errorBuilder: (context, error, stackTrace) {
              return Container();
            },
            fit: BoxFit.cover,
          ),
        ),
        Align(
          heightFactor: 3,
          widthFactor: 15,
          child: SvgPicture.asset(
            "./assets/svgs/polygon.svg",
            color: Colors.white,
            width: 30,
            height: 30,
            errorBuilder: (context, error, stackTrace) {
              return Container();
            },
            fit: BoxFit.cover,
          ),
        ),
        Align(
            heightFactor: 13,
            widthFactor: 40,
            child: SvgPicture.asset("./assets/svgs/rectangle.svg",
                color: Colors.white,
                width: 35,
                height: 20, errorBuilder: (context, error, stackTrace) {
              return Container();
            })),
      ]),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Design.surface,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Big Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              meal.strMealThumb,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback icon when image loading fails
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300], // Optional background color
                  child: Icon(
                    Icons.error,
                    size: 50, // Size of the error icon
                    color: Design.primary, // Icon color
                  ),
                );
              },
            ),
          ),

          // Meal name and description
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.strMeal,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  meal.strInstructions,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
