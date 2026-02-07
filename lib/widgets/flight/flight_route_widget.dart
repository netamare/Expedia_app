import 'package:flutter/material.dart';

class FlightRouteWidget extends StatelessWidget {
  final String from;
  final String to;
  final String departure;
  final String arrival;
  const FlightRouteWidget({required this.from, required this.to, required this.departure, required this.arrival});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(from, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 8),
        Icon(Icons.arrow_forward, size: 16),
        SizedBox(width: 8),
        Text(to, style: TextStyle(fontWeight: FontWeight.bold)),
      ]),
      SizedBox(height: 6),
      Text('$departure — $arrival', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
    ]);
  }
}