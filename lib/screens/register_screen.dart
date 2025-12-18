import 'package:flutter/material.dart';
import '/api/user_api.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  

  @override
   // ignore: library_private_types_in_public_api
   _RegisterScreen createState() => _RegisterScreen();
  }


class _RegisterScreen extends State<RegisterScreen> {
  //navigation vers la page de connexion
  void btLogIn() {
    Navigator.pushNamed(
      context,
      '/login',
    );
  }
  // clé qui gère l'état du formulaire
  final _formKey = GlobalKey<FormState>();

  //pour les champs de texte
  final _surnameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // pour la case à cocher des conditions
  bool _agreeToTerms = false;

  // libération de la mémoire 
  @override
  void dispose() {
    _surnameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
        int result = await registerUser(
          _surnameController.text,
          _nameController.text,
          _emailController.text,
          _passwordController.text
        );

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(); // retire le loader

        if (result == 201) {
          // Succès
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => AlertDialog(
            title: const Text('Inscription réussie'),
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
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Échec de l’inscription'),
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
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text('Erreur lors de l’inscription : $e'),
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
        title: const Text('Inscription'),
        backgroundColor: const Color.fromARGB(255, 242, 157, 205),
        actions: <Widget>[
          TextButton(
            onPressed: btLogIn,
            child: const Text("Se connecter"),
         ),
       ],
      ),
    body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             // Titre
              const Center(
                child: Text(
                  'Inscrivez-vous',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 30),


            //champ prénom
            TextFormField(
              controller: _surnameController,
              decoration: const InputDecoration(
                labelText: 'Prénom',
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
                  return 'Veuillez entrer votre prénom';
                } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                  return 'Veuillez n\'utiliser que des lettres';
                }
                return null; // ce return doit être à l'intérieur du validator
              },
            ),
            const SizedBox(height: 20),


            //champ nom
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom',
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
                  return 'Veuillez entrer votre nom';
                } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                  return 'Veuillez n\'utiliser que des lettres';
                }
                return null; // ce return doit être à l'intérieur du validator
              },
            ),
            const SizedBox(height: 20),


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
                  return 'Veuillez entrer un mot de passe';
                } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W]).{6,}$').hasMatch(value)) {
                  return 'Le mot de passe doit contenir au moins 6 caractères\n• Au moins une majuscule\n• Au moins une minuscule\n• Au moins un chiffre\n• Au moins un caractère spécial';
                }
                return null; 
              },
            ),
            const SizedBox(height: 20),


            //champ confirmation du mot de passe
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmer le mot de passe',
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
                  return 'Veuillez confirmer votre mot de passe';
                } else if (value != _passwordController.text) {
                  return 'Les mots de passe ne correspondent pas';
                }
                return null; 
              },
            ),
            const SizedBox(height: 20),
    
     CheckboxListTile(
      title: const Text('Accepter les termes et conditions'), 
       value:  _agreeToTerms,
       onChanged: (bool? newValue) {
        setState(() {
           _agreeToTerms = newValue!;
        });
    },
    controlAffinity: ListTileControlAffinity.leading,
),
            Center(
              child: ElevatedButton(
              onPressed:  _agreeToTerms ? _submitForm : null,
              child: const Text("S'inscrire"),
            ),
           ),
          ]
           ),
      ),
    ));
  }
}
