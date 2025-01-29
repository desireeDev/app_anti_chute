import 'package:flutter/material.dart';
import 'package:app_antichute/widgets/category_item.dart';
import 'package:app_antichute/widgets/section_title.dart';
import 'package:app_antichute/widgets/product_item.dart';
import 'package:app_antichute/screens/chute_list_screen.dart';




class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF6AB2E2), // Bleu clair
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Surveillez vos proches !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Rechercher...',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.notifications, color: Colors.white),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Alerte de chute"),
                                content: Text("Une chute a été détectée. Appeler le 118 ?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Annuler"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      print("Appel au 118 lancé...");
                                      Navigator.pop(context);
                                    },
                                    child: Text("Appeler"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Catégories
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryItem(icon: Icons.watch, label: "Montre"),
                  CategoryItem(icon: Icons.accessibility_new, label: "Chute", isHighlighted: true),
                  CategoryItem(icon: Icons.health_and_safety, label: "Santé"),
                  CategoryItem(icon: Icons.help_outline, label: "Aide"),
                ],
              ),
            ),
            SizedBox(height: 20),

          // Produits populaires
SectionTitle(title: "Populaire"),
//A chaque clic
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChuteListScreen()),
    );
  },
  child: ProductItem(
    imagePath: 'images/anti.png',
    name: 'Détecteur de Chute',
    price: '100',
  ),
),
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChuteListScreen()),
    );
  },
  child: ProductItem(
    imagePath: 'images/anti.png',
    name: 'Bracelet de Sécurité',
    price: '100',
  ),
),
     ],
        ),
      ),
    );
  }
}
