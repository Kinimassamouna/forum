import 'package:flutter/material.dart';
import '../model/message.dart';
import '../model/user.dart';
import '../api/message_api.dart';

class MessageController with ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  // Ajouter un message localement et l'envoyer au serveur
  void addMessage(String contenu, User auteur) async {
    final message = Message(
      contenu: contenu,
      date: DateTime.now(),
      auteur: auteur,
    );

    _messages.add(message);
    notifyListeners();

    // Envoyer au serveur
    await MessageUser(
      contenu,
      DateTime.now(),
      auteur.id,
    );
  }

  // Charger des messages initiaux (exemple)
  Future<void> loadMessages() async {
    _messages.addAll([
      Message(
        contenu: "Bonjour tout le monde !",
        date: DateTime.now().subtract(const Duration(minutes: 10)),
        auteur: User(
          'Dupont',
          'Jean',
          email: 'jean.dupont@example.com',
          password: '123456',
          sexe: 'Masculin',
          dateInscription: DateTime.now().subtract(const Duration(days: 30)),
        ),
      ),
      Message(
        contenu: "Salut !",
        date: DateTime.now().subtract(const Duration(minutes: 5)),
        auteur: User(
          'Leclerc',
          'Marie',
          email: 'marie.leclerc@example.com',
          password: '123456',
          sexe: 'Féminin',
          dateInscription: DateTime.now().subtract(const Duration(days: 25)),
        ),
      ),
    ]);
    notifyListeners();
  }
}
