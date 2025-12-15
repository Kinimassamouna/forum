import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
   _HomeScreen createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  //on navigue vers la page d'inscription
  void btRegister() {
    Navigator.pushNamed(
      context,
      '/register',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum', style: TextStyle(color: Color.fromARGB(255, 121, 14, 197))),
        backgroundColor: const Color.fromARGB(255, 242, 157, 205),
        actions: <Widget>[
          TextButton(
            onPressed: btRegister,
            child: const Text("S'inscrire", style: TextStyle(color: Color.fromARGB(255, 121, 14, 197))),
         ),
       ],
      ),
       body: const Center(  // Ajout du body manquant
        child: Text(
          'Bienvenue sur l\'application Forum!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
  
