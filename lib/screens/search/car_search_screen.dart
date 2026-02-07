import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../services/car_service.dart';
import '../../models/car_rental.dart';
import '../../services/car_service.dart';

class CarSearchScreen extends StatefulWidget {
  const CarSearchScreen({Key? key}) : super(key: key);
  @override
  _CarSearchScreenState createState() => _CarSearchScreenState();
}

class _CarSearchScreenState extends State<CarSearchScreen> {
  late final CarService _service;
  List<CarRental> _results = [];
  bool _loading = false;
  String _query = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // get the CarService provided at the app root
    _service = Provider.of<CarService>(context);
  }

  Future<void> _search(String q) async {
    setState(() {
      _loading = true;
      _query = q;
    });
    try {
      final all = await _service.fetchCars();
      _results = all.where((c) =>
      c.company.toLowerCase().contains(q.toLowerCase()) ||
          c.model.toLowerCase().contains(q.toLowerCase())).toList();
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
    // Provide Scaffold so TextField has a Material ancestor when this screen
    // is used as a route.
    return Scaffold(
      appBar: AppBar(title: Text('Search Cars')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(prefixIcon: Icon(Icons.directions_car), hintText: 'Search car model or company', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
            onSubmitted: _search,
          ),
        ),
        Expanded(
          child: _loading
              ? Center(child: CircularProgressIndicator())
              : _results.isEmpty && _query.isNotEmpty
              ? Center(child: Text('No cars for "$_query"'))
              : ListView.separated(
            padding: EdgeInsets.all(12),
            itemCount: _results.length,
            separatorBuilder: (_, __) => SizedBox(height: 12),
            itemBuilder: (context, i) {
              final c = _results[i];
              return ListTile(
                leading: Image.network(
                  c.imageUrl,
                  width: 72,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, st) => Container(
                    width: 72,
                    height: 48,
                    color: Colors.grey[200],
                    child: Icon(Icons.directions_car_outlined, color: Colors.grey[600]),
                  ),
                ),
                title: Text('${c.company} — ${c.model}'),
                subtitle: Text('\$${c.pricePerDay.toStringAsFixed(0)}/day'),
                trailing: ElevatedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Book (fake) ${c.model}'))),
                  child: Text('Book'),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}