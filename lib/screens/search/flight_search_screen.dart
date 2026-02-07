import 'package:flutter/material.dart';
import '../../services/flight_service.dart';
import '../../models/flight.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/flight/flight_card.dart';

class FlightSearchScreen extends StatefulWidget {
  const FlightSearchScreen({Key? key}) : super(key: key);
  @override
  _FlightSearchScreenState createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen> {
  final FlightService _service = FlightService();
  List<Flight> _results = [];
  bool _loading = false;
  String _query = '';

  Future<void> _search(String q) async {
    setState(() {
      _loading = true;
      _query = q;
    });
    try {
      final all = await _service.fetchFlights();
      _results = all.where((f) =>
      f.from.toLowerCase().contains(q.toLowerCase()) ||
          f.to.toLowerCase().contains(q.toLowerCase()) ||
          f.airline.toLowerCase().contains(q.toLowerCase())).toList();
    } catch (_) {
      _results = [];
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.flight),
              hintText: 'Search flights by city or airline',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onSubmitted: _search,
          ),
        ),
        Expanded(
          child: _loading
              ? LoadingIndicator()
              : _results.isEmpty && _query.isNotEmpty
              ? Center(child: Text('No flights for "$_query"'))
              : ListView.separated(
            padding: EdgeInsets.all(12),
            itemCount: _results.length,
            separatorBuilder: (_, __) => SizedBox(height: 12),
            itemBuilder: (context, i) => FlightCard(flight: _results[i]),
          ),
        )
      ]),
    );
  }
}