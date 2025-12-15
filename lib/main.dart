import 'package:flutter/material.dart';
import '/screens/home_screen.dart';
import '/screens/register_screen.dart';
import '/screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env.local");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(), 
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
       // '/': (context) => const HomeScreen(), car on utilise déjà home: const HomeScreen(), 
        '/register': (context) =>  RegisterScreen(),
        '/login': (context) =>  LogInScreen(),
      },
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum',  style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 242, 157, 205),
      ),
      body: const Center(
        child: Text(
          'Bienvenue sur l\'application Forum!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
