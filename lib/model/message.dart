import 'user.dart';
import 'categorie.dart';

class Message {
  final int? id;
  final String contenu;
  final DateTime date;

  // IRI pour l’API
  final String auteurIri;
  final String categorieIri;

  // Objets pour l’UI (optionnels)
  final User? auteur;
  final Categorie? categorie;

  final String? auteurNom;

  Message({
    this.id,
    required this.contenu,
    required this.date,
    required this.auteurIri,
    required this.categorieIri,
    this.auteur,
    this.categorie,
    this.auteurNom,
  });

  /// JSON → Objet
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      contenu: json['contenu'],
      date: DateTime.parse(json['date']),
      auteurIri: json['auteur'],
      categorieIri: json['categorie'],
      auteurNom: json['auteurNom'],
    );
  }

  /// Objet → JSON (POST / PATCH)
  Map<String, dynamic> toJson() {
    return {
      'contenu': contenu,
      'date': date.toIso8601String(),
      'auteur': auteurIri,
      'categorie': categorieIri,
    };
  }
}
