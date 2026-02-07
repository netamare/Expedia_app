import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  final String name;
  final String country;
  final String imageUrl;
  final VoidCallback? onTap;
  const DestinationCard({required this.name, required this.country, required this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(imageUrl, height: 90, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(country, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
            ]),
          )
        ]),
      ),
    );
  }
}