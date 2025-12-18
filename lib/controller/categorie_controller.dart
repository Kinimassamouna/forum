import 'package:flutter/material.dart';
import '../model/Categorie.dart';

class CategorieController with ChangeNotifier {
  final List<Categorie> _categories = [];

  List<Categorie> get categories => _categories;

  void addCategorie(String titre, {String description = ''}) {
    final cat = Categorie(
      id: _categories.length + 1,
      titre: titre,
      description: description,
    );
    _categories.add(cat);
    notifyListeners();
  }

  void loadCategories() {
    _categories.addAll([
      Categorie(id: 1, titre: 'Soins beauté'),
      Categorie(id: 2, titre: 'Cuisine'),
      Categorie(id: 3, titre: 'Voyages'),
    ]);
    notifyListeners();
  }

   void removeCategorie(int id) {
    _categories.removeWhere((cat) => cat.id == id);
    notifyListeners();
  }
  
}
