import 'package:flutter/material.dart';

class AirlineLogo extends StatelessWidget {
  final String airline;
  const AirlineLogo({required this.airline});
  @override
  Widget build(BuildContext context) {
    // Simple circle with airline initial for demo
    final initial = airline.isNotEmpty ? airline[0].toUpperCase() : '?';
    return CircleAvatar(child: Text(initial), backgroundColor: Colors.blue.shade50);
  }
}