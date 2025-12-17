import 'package:flutter/material.dart';
import '/api/user_api.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});
  

  @override
   _LogInScreen createState() => _LogInScreen();
  }

class _LogInScreen extends State<LogInScreen> {
  // clé qui gère l'état du formulaire
  final _formKey = GlobalKey<FormState>();

  //pour les champs de texte
  final _surnameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // libération de la mémoire 
  @override
  void dispose() {
    _surnameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

   Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        // Appel de la méthode permettant de s’inscrire avec en paramètre les données des input.
        int result = await loginUser(
          _emailController.text,
          _passwordController.text
        );

        Navigator.of(context).pop(); // retire le loader

        if (result == 200) {
          // Succès
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
            title: const Text('Connexion réussie'),
            content: Text('Bonjour, ${_surnameController.text} ${_nameController.text}!'),
            actions: <Widget>[
             TextButton(
              child: const Text('OK'),
              onPressed: () {
               Navigator.of(context).pop();
               Navigator.of(context).pushReplacementNamed('/');
               },
              ),
             ],
           ),
        );
        } else {
          // Erreur serveur
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Échec lors de la connexion'),
              content: Text(
                  'Une erreur est survenue : ${result.toString()}. Veuillez réessayer.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        // Exception réseau / JSON
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text('Erreur lors de la connexion : $e'),
            actions: <Widget>[
             TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
        backgroundColor: const Color.fromARGB(255, 242, 157, 205),
      ),
    body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),

            // Titre
              const Center(
                child: Text(
                  'Connectez-vous à votre compte',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 30),


            //champ email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                errorStyle: TextStyle(
                  color: Color.fromARGB(255, 196, 43, 160),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre email';
                } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                  return 'Veuillez entrer un email valide';
                }
                return null; // ce return doit être à l'intérieur du validator
              },
            ),
            const SizedBox(height: 20),


            //champ mot de passe
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
                errorStyle: TextStyle(
                  color: Color.fromARGB(255, 196, 43, 160),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez votre mot de passe';
                } else if (value.length < 6) {
                  return 'Le mot de passe doit contenir au moins 8 caractères\n• Au moins une majuscule\n• Au moins une minuscule\n• Au moins un chiffre\n• Au moins un caractère spécial';
                }
                return null; 
              },
            ),
            const SizedBox(height: 20),
            
            Center (
              child: ElevatedButton(
              onPressed:  _submitForm ,
              child: const Text("Se connecter"),
            ),
           ),
           const SizedBox(height: 20),

Center(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Pas encore de compte ? "),
      GestureDetector(   // Il transforme n’importe quel widget en élément cliquable / interactif
        onTap: () {
          Navigator.pushNamed(context, '/register');
        },
        child: const Text(
          "S'inscrire",
          style: TextStyle(
            color: Color.fromARGB(255, 242, 157, 205),
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  ),
),

          ]
           ),
      ),
    ));
  }
}


            
