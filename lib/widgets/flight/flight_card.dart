import 'package:flutter/material.dart';
import '../../models/flight.dart';
import 'airline_logo.dart';
import 'flight_route_widget.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;
  const FlightCard({required this.flight});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Row(children: [
        AirlineLogo(airline: flight.airline),
        SizedBox(width: 12),
        Expanded(child: FlightRouteWidget(from: flight.from, to: flight.to, departure: flight.departureTime, arrival: flight.arrivalTime)),
        SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('\$${flight.price.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 6),
          Text(flight.duration, style: TextStyle(color: Colors.grey[700])),
        ])
      ]),
    );
  }
}