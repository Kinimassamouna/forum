import 'package:flutter/material.dart';
import 'package:flutter_app_forum/model/categorie.dart';
import 'package:flutter_app_forum/model/user.dart';
import 'package:flutter_app_forum/screens/message_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Categorie> categories = [
    Categorie(id: 1, titre: 'Soins beauté'),
    Categorie(id: 2, titre: 'Cuisine'),
    Categorie(id: 3, titre: 'Voyages'),
  ];

  final User currentUser;

  CategoriesScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forums')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final categorie = categories[index];

          return Card(
            child: ListTile(
              title: Text(categorie.titre),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MessagesScreen(
                      currentUser: currentUser,
                      categorie: categorie,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
