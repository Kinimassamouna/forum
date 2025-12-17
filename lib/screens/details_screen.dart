import 'package:flutter/material.dart';
import '../model/user.dart';

class DetailScreen extends StatelessWidget {
  final User user;

  const DetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.prenom} ${user.nom}'),
        backgroundColor: Color.fromARGB(255, 242, 157, 205),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(Icons.person, 'Nom complet:', '${user.prenom} ${user.nom}'),
                _buildDetailRow(Icons.transgender, 'Sexe:', user.sexe),
                _buildDetailRow(Icons.phone, 'Téléphone:', user.telephone.isNotEmpty ? user.telephone : 'Non renseigné'),
                _buildDetailRow(Icons.home, 'Adresse:', _buildAddressText()),
                _buildDetailRow(Icons.calendar_today, 'Date d\'inscription:', _formatDate(user.dateInscription)),
                const SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Color.fromARGB(255, 242, 157, 205),
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: Color.fromARGB(255, 240, 119, 187),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Color.fromARGB(255, 240, 119, 187)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildAddressText() {
    if (user.rue.isEmpty && user.ville.isEmpty && user.codePostal.isEmpty) {
      return 'Non renseignée';
    }
    return '${user.rue}\n${user.codePostal} ${user.ville}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}