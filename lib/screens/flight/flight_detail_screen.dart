import 'package:flutter/material.dart';
import '../../models/flight.dart';

class FlightDetailScreen extends StatelessWidget {
  final Flight flight;
  const FlightDetailScreen({required this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${flight.airline} • \$${flight.price.toStringAsFixed(0)}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text('${flight.from} → ${flight.to}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Spacer(),
            Text(flight.duration, style: TextStyle(color: Colors.grey[700])),
          ]),
          SizedBox(height: 12),
          Text('Departure: ${flight.departureTime}'),
          SizedBox(height: 6),
          Text('Arrival: ${flight.arrivalTime}'),
          SizedBox(height: 12),
          Text('Airline: ${flight.airline}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking flight')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: Text('Book flight — \$${flight.price.toStringAsFixed(0)}'),
            ),
          )
        ]),
      ),
    );
  }
}