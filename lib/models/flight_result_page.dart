import 'package:flutter/material.dart';
import 'models.dart';
import 'data.dart';
import 'flight_details_page.dart';

class FlightResultsPage extends StatelessWidget {
  final City fromCity;
  final City toCity;
  final DateTime date;
  final int adults;
  final String cabin;

  const FlightResultsPage({
    Key? key,
    required this.fromCity,
    required this.toCity,
    required this.date,
    required this.adults,
    required this.cabin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String subtitle =
        "${date.month}/${date.day} · $adults traveler${adults > 1 ? "s" : ""}";
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.grey[300]!)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${fromCity.code}  "),
              const Icon(Icons.arrow_right_alt),
              Text("  ${toCity.code}"),
              const SizedBox(width: 16),
              Text(subtitle, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.grey[100],
            width: double.infinity,
            child: const Text(
              "Recommended departing flights",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...flightsMock.map((flight) => Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FlightDetailsPage(flight: flight))),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.flight_takeoff,
                                  color: Colors.blue.shade400),
                              const SizedBox(width: 8),
                              Text(
                                  "${flight.departureTime} — ${flight.arrivalTime}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              Text(
                                  "${flight.fromCode} → ${flight.toCode}",
                                  style:
                                  const TextStyle(color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${flight.airline} operated by ${flight.operator}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            "${flight.duration} • ${flight.stopText}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          if (flight.stops > 0)
                            Text(
                              "Layover: ${flight.legs[0].toCity}",
                              style: const TextStyle(fontSize: 12),
                            ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                flight.price,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 20),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("One way per traveler",
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12)),
                                  if (flight.seatsLeft > 0)
                                    Text(
                                      "${flight.seatsLeft} left at",
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              child: const Text("Flight details"),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => FlightDetailsPage(flight: flight))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[100],
            child: Row(
              children: [
                Icon(Icons.shield, color: Colors.blue.shade400),
                const SizedBox(width: 8),
                const Text("Enjoy more peace of mind by adding trip protection"),
                const Spacer(),
                OutlinedButton.icon(
                  icon: const Icon(Icons.filter_list),
                  label: const Text("Sort & Filter"),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}