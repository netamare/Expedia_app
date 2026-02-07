import 'package:flutter/material.dart';

class TripDetailScreen extends StatelessWidget {
  final String title;
  const TripDetailScreen({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Trip details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('This is a demo trip detail screen with fake data.'),
      ])),
    );
  }
}