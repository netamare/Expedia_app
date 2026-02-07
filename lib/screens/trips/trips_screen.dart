import 'package:expedia_app/screens/trips/trip_detail_screen.dart';
import 'package:flutter/material.dart';

class TripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fake trips list
    final trips = [
      {'title': 'Miami Weekend', 'subtitle': '2 nights, 1 room', 'date': 'Apr 12 - Apr 14'},
      {'title': 'Aspen Ski', 'subtitle': '4 nights, 2 rooms', 'date': 'Dec 20 - Dec 24'},
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Trips')),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: trips.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, i) {
          final t = trips[i];
          return ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(t['title']!),
            subtitle: Text('${t['subtitle']} • ${t['date']}'),
            trailing: Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TripDetailScreen(title: t['title']!))),
          );
        },
      ),
    );
  }
}