import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/message_controller.dart';
import '../model/user.dart';


class MessagesScreen extends StatefulWidget {
  final User currentUser; // utilisateur connecté
  const MessagesScreen({super.key, required this.currentUser});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late MessageController _controller;
  final TextEditingController _messageController = TextEditingController();

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

    // Ajouter le message localement et notifier les listeners
    _controller.addMessage(contenu, widget.currentUser);

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
          title: const Text('Messages'),
          backgroundColor: const Color.fromARGB(255, 242, 157, 205),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<MessageController>(
                builder: (context, controller, child) {
                  final messages = controller.messages;
                  if (messages.isEmpty) {
                    return const Center(child: Text("Aucun message"));
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[messages.length - 1 - index];
                      final auteur = message.auteur; // User
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(message.contenu),
                          subtitle: Text(
                              "Par ${auteur.prenom} ${auteur.nom} • ${message.date.toLocal().toString().substring(0,16)}"),
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
