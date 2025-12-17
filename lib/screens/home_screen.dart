import 'package:flutter/material.dart';
import 'package:flutter_app_forum/controller/user_controller.dart';
import 'package:flutter_app_forum/model/user.dart';
import 'package:flutter_app_forum/screens/details_screen.dart';
import 'package:flutter_app_forum/screens/message_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController _userController = UserController();

  @override
  void initState() {
    super.initState();
    _userController.loadUsers();
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: _userController.users.length,
      itemBuilder: (BuildContext context, int index) {
        User user = _userController.users[index];
        return Dismissible(
          key: ValueKey(user.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            setState(() {
              _userController.removeUserAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Utilisateur supprimé'),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red,
              ),
            );
          },
          background: Container(
            color: const Color.fromARGB(255, 242, 157, 205),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.person,
                  color: Color.fromARGB(255, 240, 119, 187)),
              title: Text('${user.prenom} ${user.nom}'),
              subtitle:
                  Text(user.telephone.isNotEmpty ? user.telephone : 'Pas de téléphone'),
              trailing: Icon(
                user.sexe == 'Féminin' ? Icons.female : Icons.male,
                color: user.sexe == 'Féminin' ? Colors.pink : Colors.blue,
              ),
              onTap: () => _navigateToDetail(context, user),
            ),
          ),
        );
      },
    );
  }

  void _navigateToDetail(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(user: user),
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController nomController = TextEditingController();
    TextEditingController prenomController = TextEditingController();
    TextEditingController telephoneController = TextEditingController();
    TextEditingController rueController = TextEditingController();
    TextEditingController villeController = TextEditingController();
    TextEditingController codePostalController = TextEditingController();

    String? selectedSexe = 'Non spécifié';
    final List<String> sexeOptions = ['Masculin', 'Féminin', 'Non spécifié'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter un utilisateur', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nomController,
                    decoration: const InputDecoration(
                      labelText: 'Nom*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Le nom est obligatoire';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: prenomController,
                    decoration: const InputDecoration(
                      labelText: 'Prénom*',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Le prénom est obligatoire';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedSexe,
                    decoration: const InputDecoration(
                      labelText: 'Sexe',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.transgender),
                    ),
                    items: sexeOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedSexe = newValue;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: telephoneController,
                    decoration: const InputDecoration(
                      labelText: 'Téléphone',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: rueController,
                    decoration: const InputDecoration(
                      labelText: 'Rue',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.home),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: villeController,
                    decoration: const InputDecoration(
                      labelText: 'Ville',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: codePostalController,
                    decoration: const InputDecoration(
                      labelText: 'Code postal',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.markunread_mailbox),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _userController.addUser(
                      nomController.text.trim(),
                      prenomController.text.trim(),
                      sexe: selectedSexe ?? 'Non spécifié',
                      telephone: telephoneController.text.trim(),
                      rue: rueController.text.trim(),
                      ville: villeController.text.trim(),
                      codePostal: codePostalController.text.trim(),
                      email: '${prenomController.text.toLowerCase()}.${nomController.text.toLowerCase()}@example.com', // exemple
                      password: '123456', // mot de passe par défaut
                      dateInscription: DateTime.now(),
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Utilisateur ajouté'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 242, 157, 205),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Ajouter', style: TextStyle(color: Colors.white)),
            ),
          ],
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _showAddUserDialog(context),
            tooltip: 'Ajouter un utilisateur',
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            child: const Text("S'inscrire"),
          ),
          IconButton(
            icon: const Icon(Icons.message),
            tooltip: 'Messages',
            onPressed: () {
              if (_userController.users.isNotEmpty) {
                final User currentUser = _userController.users[0]; // utilisateur connecté
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagesScreen(currentUser: currentUser),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Aucun utilisateur connecté'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: _buildUserList(),
    );
  }
}
