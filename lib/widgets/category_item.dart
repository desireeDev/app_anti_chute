import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isHighlighted;

  const CategoryItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isHighlighted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.red : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: isHighlighted ? Colors.white : Colors.black),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(color: isHighlighted ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
