import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/flight_service.dart';
import '../../widgets/flight/flight_card.dart';
import '../../widgets/booking/passenger_selector.dart';
import '../../widgets/flight/cabin_selector.dart';
import '../../services/search_history_service.dart';
import '../../services/price_alert_service.dart';

class FlightSearchScreen extends StatefulWidget {
  const FlightSearchScreen({Key? key}) : super(key: key);
  @override
  _FlightSearchScreenState createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _tripType = 0;
  final TextEditingController _fromCtrl = TextEditingController(text: 'Addis Ababa (ADD)');
  final TextEditingController _toCtrl = TextEditingController(text: '');
  DateTimeRange? _dates;
  PassengerData passengers = const PassengerData(adults: 1, children: 0, infants: 0);
  CabinClass cabin = CabinClass.economy;
  bool _addCar = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() => setState(() {
      _tripType = _controller.index;
    }));
  }

  @override
  void dispose() {
    _controller.dispose();
    _fromCtrl.dispose();
    _toCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDates() async {
    final picked = await showDateRangePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
    if (picked != null) setState(() => _dates = picked);
  }

  void _swap() {
    final a = _fromCtrl.text;
    _fromCtrl.text = _toCtrl.text;
    _toCtrl.text = a;
  }

  Future<void> _search() async {
    final flightService = context.read<FlightService>();
    final history = context.read<SearchHistoryService>();
    // record recent search
    history.add(SearchEntry(type: 'flight', query: '${_fromCtrl.text} → ${_toCtrl.text}'));

    // fake fetch
    final all = await flightService.fetchFlights();
    final filtered = all.where((f) {
      final fromMatch = _fromCtrl.text.isEmpty || f.from.toLowerCase().contains(_fromCtrl.text.toLowerCase());
      final toMatch = _toCtrl.text.isEmpty || f.to.toLowerCase().contains(_toCtrl.text.toLowerCase());
      return fromMatch && toMatch;
    }).toList();

    if (filtered.isEmpty) {
      // offer to set a price alert
      final priceAlertSvc = context.read<PriceAlertService>();
      showModalBottomSheet(context: context, builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('No flights found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('Would you like to create a price alert for this route?'),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                priceAlertSvc.createAlert(PriceAlert(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'flight', query: '${_fromCtrl.text} → ${_toCtrl.text}', targetPrice: 100.0));
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Price alert created (demo)')));
              },
              child: Text('Create price alert'),
            )
          ]),
        );
      });
      return;
    }

    // show results in modal bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: false,
          builder: (ctx, scrollCtr) {
            return ListView.builder(
              controller: scrollCtr,
              padding: EdgeInsets.all(12),
              itemCount: filtered.length,
              itemBuilder: (context, i) => FlightCard(flight: filtered[i]),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final history = context.watch<SearchHistoryService>();
    return Scaffold(
      appBar: AppBar(title: Text('Flights')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              TabBar(
                controller: _controller,
                tabs: [Tab(text: 'Roundtrip'), Tab(text: 'One-way'), Tab(text: 'Multi-city')],
                labelColor: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 12),
              Row(children: [
                Expanded(
                  child: TextField(controller: _fromCtrl, decoration: InputDecoration(prefixIcon: Icon(Icons.flight_takeoff), labelText: 'Leaving from')),
                ),
                SizedBox(width: 8),
                Column(children: [
                  IconButton(onPressed: _swap, icon: Icon(Icons.swap_vert)),
                ]),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(controller: _toCtrl, decoration: InputDecoration(prefixIcon: Icon(Icons.place), labelText: 'Going to')),
                ),
              ]),
              SizedBox(height: 12),
              Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickDates,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                      child: Row(children: [
                        Icon(Icons.calendar_today, color: Colors.grey),
                        SizedBox(width: 12),
                        Expanded(child: Text(_dates == null ? 'Select dates' : '${_dates!.start.month}/${_dates!.start.day} - ${_dates!.end.month}/${_dates!.end.day}')),
                        Icon(Icons.chevron_right, color: Colors.grey),
                      ]),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => showModalBottomSheet(context: context, builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: PassengerSelector(
                        initial: passengers,
                        onChanged: (p) => setState(() => passengers = p),
                      ),
                    );
                  }),
                  child: Text('Passengers'),
                )
              ]),
              SizedBox(height: 12),
              Row(children: [
                Text('Cabin:'),
                SizedBox(width: 12),
                CabinSelector(value: cabin, onChanged: (c) => setState(() => cabin = c)),
                Spacer(),
                Row(children: [
                  Checkbox(value: _addCar, onChanged: (v) => setState(() => _addCar = v ?? false)),
                  Text('Add a car'),
                ]),
              ]),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _search,
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 14), minimumSize: Size(double.infinity, 48)),
                child: Text('Search', style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 12),
              RecentSection(entries: history.recent.toList(), onTap: (e) {
                // when tapping a recent entry, populate fields quickly
                if (e.type == 'flight') {
                  final parts = e.query.split('→');
                  if (parts.length == 2) {
                    _fromCtrl.text = parts[0].trim();
                    _toCtrl.text = parts[1].trim();
                  } else {
                    _toCtrl.text = e.query;
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentSection extends StatelessWidget {
  final List<SearchEntry> entries;
  final void Function(SearchEntry) onTap;
  const RecentSection({Key? key, required this.entries, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 8),
      Text('Recent searches', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: entries.map((e) => ActionChip(label: Text(e.query), onPressed: () => onTap(e))).toList(),
      )
    ]);
  }
}