import 'package:flutter/material.dart';
import 'models.dart';

class FlightDetailsPage extends StatelessWidget {
  final Flight flight;

  const FlightDetailsPage({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Flight details", style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          ...flight.legs.asMap().entries.map((entry) {
            final i = entry.key + 1;
            final leg = entry.value;
            return Container(
              margin: EdgeInsets.only(bottom: i == flight.legs.length ? 18 : 30),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.flight, size: 20),
                        const SizedBox(width: 7),
                        Text("${leg.airline} ${leg.flightNumber}",
                            style:
                            const TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text(
                          "Flight $i of ${flight.legs.length}",
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(leg.fromCity,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text(
                                "${leg.fromAirport} (${leg.terminalFrom})\n${leg.depTime}",
                                style: const TextStyle(fontSize: 12)),
                            const SizedBox(height: 6),
                            const Icon(Icons.more_vert, size: 16),
                            const SizedBox(height: 6),
                            Text(leg.toCity,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text(
                                "${leg.toAirport} (${leg.terminalTo})\n${leg.arrTime}",
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text("Travel time: ${leg.travelTime}",
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    if (i != flight.legs.length)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "${flight.duration.split('•').last} layover in ${leg.toCity}",
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                  ]),
            );
          }),
          ListTile(
            title: const Text("Aircraft"),
            trailing: Text(flight.legs.first.aircraft),
          ),
          ListTile(
            title: const Text("Cabin"),
            trailing: Text(flight.cabin),
          ),
          ListTile(
            title: const Text("Distance"),
            trailing: Text(flight.legs.first.distance),
          ),
          ListTile(
            title: const Text("Emissions"),
            trailing: Text(flight.legs.first.emission, style: TextStyle(color: Colors.green)),
          ),
          const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 4),
              child: Text("Amenities", style: TextStyle(fontWeight: FontWeight.bold))),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 6),
            child: Wrap(
              spacing: 16,
              children: flight.legs.first.amenities
                  .map((a) => Chip(label: Text(a)))
                  .toList(),
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {},
              child: const Text("See fares", style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}