import 'package:flutter/material.dart';
import '../../services/flight_service.dart';
import '../../models/flight.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/flight/flight_card.dart';
import 'flight_detail_screen.dart';

class FlightListScreen extends StatefulWidget {
  @override
  _FlightListScreenState createState() => _FlightListScreenState();
}

class _FlightListScreenState extends State<FlightListScreen> {
  final FlightService _service = FlightService();
  bool loading = true;
  String error = '';
  List<Flight> flights = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = '';
    });
    try {
      flights = await _service.fetchFlights();
    } catch (e) {
      error = 'Unable to load flights';
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void _openDetail(Flight flight) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FlightDetailScreen(flight: flight)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flights')),
      body: loading
          ? LoadingIndicator()
          : error.isNotEmpty
          ? Center(child: Text(error))
          : RefreshIndicator(
        onRefresh: _load,
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: flights.length,
          itemBuilder: (context, i) {
            final f = flights[i];
            return GestureDetector(
              onTap: () => _openDetail(f),
              child: FlightCard(flight: f),
            );
          },
        ),
      ),
    );
  }
}