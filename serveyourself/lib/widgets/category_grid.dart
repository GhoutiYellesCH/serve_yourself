import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  final List<String> categories;

  CategoryGrid({required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Card(child: Center(child: Text(categories[index])));
      },
    );
  }
}
