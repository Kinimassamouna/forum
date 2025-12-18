import 'package:flutter/material.dart';
import 'package:flutter_app_forum/controller/user_controller.dart';
import 'package:flutter_app_forum/model/user.dart';
import 'package:flutter_app_forum/model/categorie.dart';
import 'package:flutter_app_forum/screens/details_screen.dart';
import 'package:flutter_app_forum/screens/message_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController _userController = UserController();

  // Liste des catégories
  final List<Categorie> categories = [
    Categorie(id: 1, titre: 'Soins beauté'),
    Categorie(id: 2, titre: 'Cuisine'),
    Categorie(id: 3, titre: 'Voyages'),
  ];

  Categorie? selectedCategory;

  @override
  void initState() {
    super.initState();
    _userController.loadUsers();
    selectedCategory = categories[0]; // catégorie par défaut
  }

  void _navigateToMessages() {
    if (_userController.users.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aucun utilisateur connecté'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une catégorie'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final User currentUser = _userController.users[0];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MessagesScreen(
          currentUser: currentUser,
          categorie: selectedCategory!,
        ),
      ),
    );
  }

  void _showAddUserDialog() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final nomController = TextEditingController();
    final prenomController = TextEditingController();
    final telephoneController = TextEditingController();
    final villeController = TextEditingController();
    DateTime? selectedDate;
    String selectedSexe = 'Non spécifié';
    final sexeOptions = ['Masculin', 'Féminin', 'Non spécifié'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un utilisateur', textAlign: TextAlign.center),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nomController,
                decoration: const InputDecoration(labelText: 'Nom', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Nom obligatoire' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: prenomController,
                decoration: const InputDecoration(labelText: 'Prénom', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Prénom obligatoire' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedSexe,
                items: sexeOptions.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (value) => selectedSexe = value ?? 'Non spécifié',
                decoration: const InputDecoration(labelText: 'Sexe', border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _userController.addUser(
                  nomController.text.trim(),
                  prenomController.text.trim(),
                  sexe: selectedSexe,
                  telephone: telephoneController.text.trim(),
                  ville: villeController.text.trim(),
                  dateInscription: selectedDate!,
                 );
                Navigator.pop(context);
                setState(() {}); // Mettre à jour la liste
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog() {
    final titreController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un forum', textAlign: TextAlign.center),
        content: TextField(
          controller: titreController,
          decoration: const InputDecoration(labelText: 'Nom du forum'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () {
              if (titreController.text.trim().isNotEmpty) {
                final newCategory = Categorie(
                  id: categories.length + 1,
                  titre: titreController.text.trim(),
                );
                setState(() {
                  categories.add(newCategory);
                  selectedCategory = newCategory;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<Categorie>(
        value: selectedCategory,
        decoration: const InputDecoration(
          labelText: "Choisir un forum",
          border: OutlineInputBorder(),
        ),
        items: categories.map((cat) {
          return DropdownMenuItem(
            value: cat,
            child: Text(cat.titre),
          );
        }).toList(),
        onChanged: (cat) {
          setState(() {
            selectedCategory = cat;
          });
        },
      ),
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: _userController.users.length,
      itemBuilder: (context, index) {
        final user = _userController.users[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: user.sexe == 'Féminin' ? Colors.pink[100] : Colors.blue[100],
              child: Icon(
                user.sexe == 'Féminin' ? Icons.female : Icons.male,
                color: user.sexe == 'Féminin' ? Colors.pink : Colors.blue,
              ),
            ),
            title: Text('${user.prenom} ${user.nom}'),
            subtitle: Text(user.telephone.isNotEmpty ? user.telephone : 'Pas de téléphone'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(user: user),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum'),
        backgroundColor: const Color.fromARGB(255, 242, 157, 205),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            tooltip: 'Ajouter un utilisateur',
            onPressed: _showAddUserDialog,
          ),
          IconButton(
            icon: const Icon(Icons.add_circle),
            tooltip: 'Ajouter un forum',
            onPressed: _showAddCategoryDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategorySelector(),
          ElevatedButton(
            onPressed: _navigateToMessages,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 242, 157, 205),
            ),
            child: const Text('Accéder au forum sélectionné'),
          ),
          const SizedBox(height: 10),
          Expanded(child: _buildUserList()),
        ],
      ),
    );
  }
}
