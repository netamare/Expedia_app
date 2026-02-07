import 'package:flutter/material.dart';

class AmenityChip extends StatelessWidget {
  final String label;
  const AmenityChip(this.label);
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: TextStyle(fontSize: 12)),
      backgroundColor: Colors.grey.shade100,
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    );
  }
}