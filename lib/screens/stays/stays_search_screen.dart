import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/hotel_service.dart';
import '../../widgets/hotel/hotel_card.dart';
import '../../widgets/booking/date_selector.dart';
import '../../widgets/booking/guest_selector.dart';
import '../../services/search_history_service.dart';
import '../../models/hotel.dart';

class StaysSearchScreen extends StatefulWidget {
  const StaysSearchScreen({Key? key}) : super(key: key);

  @override
  _StaysSearchScreenState createState() => _StaysSearchScreenState();
}

class _StaysSearchScreenState extends State<StaysSearchScreen> {
  final TextEditingController _where = TextEditingController();
  DateTimeRange? _dates;
  int _nights = 1;
  int _guests = 2;
  bool wifi = false;
  double maxPrice = 500;

  Future<void> _pickDates() async {
    final picked = await showDateRangePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
    if (picked != null) {
      setState(() {
        _dates = picked;
        _nights = picked.duration.inDays;
      });
    }
  }

  Future<void> _search() async {
    final svc = context.read<HotelService>();
    final history = context.read<SearchHistoryService>();
    history.add(SearchEntry(type: 'stay', query: _where.text.isNotEmpty ? _where.text : 'Anywhere'));

    final all = await svc.fetchHotels();
    final results = all.where((h) {
      final q = _where.text.toLowerCase();
      final matchPlace = q.isEmpty || h.name.toLowerCase().contains(q) || h.location.toLowerCase().contains(q);
      final matchPrice = h.price <= maxPrice;
      return matchPlace && matchPrice;
    }).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          expand: false,
          builder: (ctx, controller) {
            if (results.isEmpty) {
              return ListView(children: [Padding(padding: EdgeInsets.all(20), child: Text('No stays found for your search.'))]);
            }
            return ListView.builder(
              controller: controller,
              padding: EdgeInsets.all(12),
              itemCount: results.length,
              itemBuilder: (context, i) => HotelCard(hotel: results[i]),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final recent = context.watch<SearchHistoryService>().recent.where((e) => e.type == 'stay').toList();
    return Scaffold(
      appBar: AppBar(title: Text('Stays')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            TextField(controller: _where, decoration: InputDecoration(prefixIcon: Icon(Icons.place), hintText: 'Where to?')),
            SizedBox(height: 12),
            InkWell(onTap: _pickDates, child: Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
              child: Row(children: [Icon(Icons.calendar_today), SizedBox(width: 12), Text(_dates == null ? 'Select dates' : '${_dates!.start.month}/${_dates!.start.day} - ${_dates!.end.month}/${_dates!.end.day}')]),
            )),
            SizedBox(height: 12),
            Row(children: [Expanded(child: Text('Guests')), SizedBox(width: 12), Text('$_guests')]),
            SizedBox(height: 12),
            Row(children: [
              Expanded(child: Row(children: [Checkbox(value: wifi, onChanged: (v) => setState(() => wifi = v ?? false)), Text('Free wifi')])),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('Max price'), Text('\$${maxPrice.toStringAsFixed(0)}')])),
            ]),
            Slider(value: maxPrice, min: 50, max: 1000, divisions: 19, label: '\$${maxPrice.toStringAsFixed(0)}', onChanged: (v) => setState(() => maxPrice = v)),
            SizedBox(height: 12),
            ElevatedButton(onPressed: _search, child: Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Search', style: TextStyle(fontSize: 16)))),
            SizedBox(height: 16),
            if (recent.isNotEmpty) Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Recent searches', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Wrap(spacing: 8, children: recent.map((e) => ActionChip(label: Text(e.query), onPressed: () {
                _where.text = e.query;
              })).toList())
            ])
          ]),
        ),
      ),
    );
  }
}