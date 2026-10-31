import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
 
class Historiquepage extends StatefulWidget {
  const Historiquepage({super.key});
 
  @override
  State<Historiquepage> createState() => _HistoriquepageState();
}
 
class _HistoriquepageState extends State<Historiquepage> {
  // Liste fictive pour l'historique
  final List<Map<String, dynamic>> historique = [
    {
      'title': 'Café Gourmand',
      'date': '20 - Feb - 25',
      'hour': '20:00',
      'imageUrl': 'https://via.placeholder.com/100', // Remplace avec ta vraie image
    },
    {
      'title': 'Pizza Margherita',
      'date': '21 - Feb - 25',
      'hour': '21:00',
      'imageUrl': 'https://via.placeholder.com/100',
    },
    // Tu peux en ajouter d'autres
  ];
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique'),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop() ,
        ),
      ),
      body: Container(
        color: const Color(0xFFFFEED2),
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: historique.length,
          itemBuilder: (context, index) {
            final item = historique[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFFF5F00)),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item['imageUrl'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Date : ${item['date']}",
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          "Heure : ${item['hour']}",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
 
 

