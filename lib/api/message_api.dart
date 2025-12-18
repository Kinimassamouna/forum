import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: non_constant_identifier_names
Future<int> MessageUser(
  String contenu,
  DateTime date,
  String auteurIri, // <-- changer int en String
  int categorieIri,
) async {
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  final uri = Uri.parse("$baseUrl/messages");

  final headers = {
    'Content-Type': 'application/ld+json',
    'Accept': 'application/ld+json',
  };

  final body = json.encode({
    'contenu': contenu,
    'date': date.toIso8601String(),
    'auteur':  auteurIri,
    'categorie':categorieIri,
  });

  try {
    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
      return 201;
    } else {
      print("Échec : ${response.statusCode}\nRéponse : ${response.body}");
      return response.statusCode;
    }
  } catch (e) {
    print("Exception lors de la requête : $e");
    return 0; // Erreur réseau
  }
}
