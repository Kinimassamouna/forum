import 'package:uuid/uuid.dart';

class User {
  final String id; // clé unique
  String _nom;
  String _prenom;
  String email; 
  String password; 
  String sexe;
  DateTime dateInscription;

  String telephone;
  String rue;
  String ville;
  String codePostal;

  User(
    this._nom,
    this._prenom, {
    String? id,
    required this.email, // Ajouter required
    required this.password, 
    this.sexe = '',
    required this.dateInscription, 
    this.telephone = '',
    this.rue = '',
    this.ville = '',
    this.codePostal = '',
  }) : id = id ?? const Uuid().v4();

  String get nom => _nom;
  String get prenom => _prenom;

  set nom(String value) {
    if (value.isNotEmpty) {
      _nom = value;
    }
  }

  set prenom(String value) {
    if (value.isNotEmpty) {
      _prenom = value;
    }
  }
}
