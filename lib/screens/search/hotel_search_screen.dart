import 'package:flutter/material.dart';
import '../../services/hotel_service.dart';
import '../../models/hotel.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/hotel/hotel_card.dart';

class HotelSearchScreen extends StatefulWidget {
  const HotelSearchScreen({Key? key}) : super(key: key);
  @override
  _HotelSearchScreenState createState() => _HotelSearchScreenState();
}

class _HotelSearchScreenState extends State<HotelSearchScreen> {
  final HotelService _service = HotelService();
  List<Hotel> _results = [];
  bool _loading = false;
  String _query = '';

  Future<void> _search(String q) async {
    setState(() {
      _loading = true;
      _query = q;
    });
    try {
      final all = await _service.fetchHotels();
      _results = all.where((h) =>
      h.name.toLowerCase().contains(q.toLowerCase()) ||
          h.location.toLowerCase().contains(q.toLowerCase())).toList();
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
    // This screen is safe to use both as a standalone route and inside a TabBarView.
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search hotels or destinations',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onSubmitted: _search,
          ),
        ),
        Expanded(
          child: _loading
              ? LoadingIndicator()
              : _results.isEmpty && _query.isNotEmpty
              ? Center(child: Text('No results for "$_query"'))
              : ListView.separated(
            padding: EdgeInsets.all(12),
            itemCount: _results.length,
            separatorBuilder: (_, __) => SizedBox(height: 12),
            itemBuilder: (context, i) => HotelCard(hotel: _results[i]),
          ),
        )
      ]),
    );
  }
}