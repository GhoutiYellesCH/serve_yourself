import 'package:flutter/material.dart';

class AddrecipePage extends StatefulWidget {
  const AddrecipePage({super.key});

  @override
  State<AddrecipePage> createState() => _AddrecipePageState();
}

class _AddrecipePageState extends State<AddrecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une recette'),
      ),
      body: const Center(
        child: Text('Ajouter une recette'),
      ),
      
    );
  }
}
