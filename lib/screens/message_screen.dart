import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/message_controller.dart';
import '../model/user.dart';
import '../model/categorie.dart';

class MessagesScreen extends StatefulWidget {
  final User currentUser; // utilisateur connecté
  final Categorie categorie;

  const MessagesScreen({super.key, required this.currentUser, required this.categorie,});

  @override
  // ignore: library_private_types_in_public_api
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late MessageController _controller;
  final TextEditingController _messageController = TextEditingController();
 

  // Liste de catégories
  final List<Categorie> categories = [
    Categorie(id: 1, titre: 'Soins beauté'),
    Categorie(id: 2, titre: 'Cuisine'),
    Categorie(id: 3, titre: 'Voyages'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = MessageController();
    _controller.loadMessages(); // charger les messages initiaux
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final contenu = _messageController.text.trim();
    if (contenu.isEmpty) return;
    _controller.addMessage(
    contenu,
    widget.currentUser,
    widget.categorie, // 👈 catégorie du forum
    );

    _messageController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Message envoyé'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessageController>.value(
      value: _controller,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.categorie.titre), // 👈 nom du forum
          backgroundColor: const Color.fromARGB(255, 242, 157, 205),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<MessageController>(
                builder: (context, controller, child) {
                  final messages = controller.messagesByCategorie(widget.categorie);
                  if (messages.isEmpty) {
                    return const Center(child: Text("Aucun message"));
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[messages.length - 1 - index];
                      final auteur = message.auteur;

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(message.contenu),
                          subtitle: Text(
                              "Par ${auteur?.prenom} ${auteur?.nom} • ${message.date.toLocal().toString().substring(0,16)}"),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Écrire un message...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 242, 157, 205),
                    ),
                    child: const Text('Envoyer'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
