import 'package:flutter/material.dart';
import '../model/user.dart';

class UserController with ChangeNotifier {
  final List<User> _users = [];
  User? _currentUser;

  // Getters
  List<User> get users => _users;
  User? get currentUser => _currentUser;

  // Charger les utilisateurs
  void loadUsers() {
    _users.addAll([
      User(
        'Dupont',
        'Jean',
        email: 'jean@example.com',
        password: '123456',
        sexe: 'Masculin',
        dateInscription: DateTime.now(),
      ),
      User(
        'Durand',
        'Pierre',
        email: 'pierre@example.com',
        password: '123456',
        sexe: 'Masculin',
        dateInscription: DateTime.now(),
      ),
      User(
        'Martin',
        'Paul',
        email: 'paul@example.com',
        password: '123456',
        sexe: 'Masculin',
        dateInscription: DateTime.now(),
      ),
      User(
        'Leclerc',
        'Marie',
        email: 'marie@example.com',
        password: '123456',
        sexe: 'Féminin',
        dateInscription: DateTime.now(),
      ),
      User(
        'Bertrand',
        'Luc',
        email: 'luc@example.com',
        password: '123456',
        sexe: 'Masculin',
        dateInscription: DateTime.now(),
      ),
    ]);
  }

  // Connexion
  bool login(String email, String password) {
    try {
      final user = _users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      _currentUser = user;
      return true;
    } catch (_) {
      return false;
    }
  }

  // Déconnexion
  void logout() {
    _currentUser = null;
  }

  // Ajouter un utilisateur
  void addUser(
    String nom,
    String prenom, {
    String email = '',
    String password = '',
    String sexe = 'Non spécifié',
    String telephone = '',
    String rue = '',
    String ville = '',
    String codePostal = '',
    DateTime? dateInscription,
  }) {
    _users.add(
      User(
        nom,
        prenom,
        email: email,
        password: password,
        sexe: sexe,
        telephone: telephone,
        rue: rue,
        ville: ville,
        codePostal: codePostal,
        dateInscription: dateInscription ?? DateTime.now(),
      ),
    );
  }

  void sortByPrenom() {
    _users.sort((a, b) => a.prenom.compareTo(b.prenom));
  }

  void removeUserAt(int index) {
      _users.removeAt(index);
    }
  }

