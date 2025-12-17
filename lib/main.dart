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
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomeScreen(), 
        '/register': (context) =>  RegisterScreen(),
        '/login': (context) =>  LogInScreen(),
      },
    );
  }
}

  
