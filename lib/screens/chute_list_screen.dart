import 'package:flutter/material.dart';

class ChuteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Liste des chutes fictives
    List<Map<String, String>> chutes = [
      {"date": "2024-01-28", "heure": "14:30", "lieu": "Salon"},
      {"date": "2024-01-26", "heure": "10:15", "lieu": "Chambre"},
      {"date": "2024-01-25", "heure": "08:00", "lieu": "Salle de bain"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Historique des Chutes"),
        backgroundColor: Color(0xFF6AB2E2), // Bleu clair
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: chutes.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(Icons.warning, color: Colors.red),
                title: Text(
                  "Chute détectée",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    "Date: ${chutes[index]["date"]} | Heure: ${chutes[index]["heure"]}\nLieu: ${chutes[index]["lieu"]}"),
                trailing: Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  print("Détails de la chute sélectionnée");
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
