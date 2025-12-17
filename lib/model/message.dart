import 'package:flutter_app_forum/model/user.dart';

class Message {
  final int? id;
  final String contenu;
  final DateTime date;
  final User auteur; // IRI : ex "/users/1"
  final String? auteurNom; // optionnel : pour afficher le nom


  Message({
    this.id,
    required this.contenu,
    required this.date,
    required this.auteur,
    this.auteurNom,
  });

  /// JSON → Objet
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      contenu: json['contenu'],
      date: DateTime.parse(json['date']),
      auteur: json['auteur'],
      auteurNom: json['auteurNom'], // si backend renvoie nom complet
    );
  }

  /// Objet → JSON (pour POST)
  Map<String, dynamic> toJson() {
    return {
      'contenu': contenu,
      'date': date.toIso8601String(),
      'auteur': auteur, // ex "/users/1"
    };
  }
}