import 'package:flutter/material.dart';
import '../model/message.dart';
import '../model/user.dart';
import '../model/categorie.dart';
import '../api/message_api.dart';

class MessageController with ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  // Filtrer par catégorie
  List<Message> messagesByCategorie(Categorie categorie) {
    return _messages
        .where((message) => message.categorie != null && message.categorie!.id == categorie.id)
        .toList();
  }

  // Ajouter un message localement et l'envoyer au serveur
  void addMessage(String contenu, User auteur, Categorie categorie) async {
    final message = Message(
      contenu: contenu,
      date: DateTime.now(),
      auteur: auteur,
      categorie: categorie,
      auteurIri: '/users/${auteur.id}',
      categorieIri: '/categories/${categorie.id}',
      auteurNom: '${auteur.prenom} ${auteur.nom}',
    );

    _messages.add(message);
    notifyListeners();

    // Envoyer au serveur
    await MessageUser(
      contenu,
      DateTime.now(),
      auteur.id,        // int
      categorie.id, 
    );
  }

  // Charger des messages initiaux (exemple)
  Future<void> loadMessages() async {
    final catVoyages = Categorie(id: 1, titre: 'Voyages');
    final catCuisine = Categorie(id: 2, titre: 'Cuisine');

    _messages.addAll([
      Message(
        contenu: "Bienvenue dans le forum Voyages ✈️",
        date: DateTime.now().subtract(const Duration(minutes: 10)),
        auteur: User(
          'Dupont',
          'Jean',
          email: 'jean.dupont@example.com',
          password: '123456',
          sexe: 'Masculin',
          dateInscription: DateTime.now().subtract(const Duration(days: 30)),
        ),
        categorie: catVoyages,
        auteurIri: '/users/1',
        categorieIri: '/categories/1',
      ),
      Message(
        contenu: "Recette facile de gâteau 🍰",
        date: DateTime.now().subtract(const Duration(minutes: 5)),
        auteur: User(
          'Leclerc',
          'Marie',
          email: 'marie.leclerc@example.com',
          password: '123456',
          sexe: 'Féminin',
          dateInscription: DateTime.now().subtract(const Duration(days: 25)),
        ),
        categorie: catCuisine,
        auteurIri: '/users/2',
        categorieIri: '/categories/2',
      ),
    ]);
    notifyListeners();
  }
}
