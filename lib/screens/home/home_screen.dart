import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/strings.dart';
import '../../widgets/common/logo_widget.dart';
import '../../widgets/home/category_card.dart';
import '../../widgets/home/featured_hotel_card.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../constants/colors.dart';
import '../../screens/flight/flight_search_screen.dart';
import '../../widgets/booking/passenger_selector.dart';
import '../../screens/stays/stays_search_screen.dart';
import '../../screens/search/search_screen.dart';
import '../home/home_view_model.dart';
import '../../services/search_history_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool addFlight = false;
  bool addCar = false;
  DateTimeRange? _dates;
  String _where = '';
  PassengerData passengers = const PassengerData(adults: 2, children: 0, infants: 0);

  Future<void> _pickDates() async {
    final picked = await showDateRangePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
    if (picked != null) setState(() => _dates = picked);
  }

  Future<void> _showPassengers() async {
    await showModalBottomSheet(context: context, builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: PassengerSelector(
          initial: passengers,
          onChanged: (p) => setState(() => passengers = p),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context);
    final history = Provider.of<SearchHistoryService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Row(
          children: [
            LogoWidget(height: 36),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$15.00 in OneKeyCash', style: TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
            SizedBox(width: 8),
            InkWell(onTap: () => Navigator.pushNamed(context, '/profile'), child: CircleAvatar(child: Icon(Icons.person))),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: vm.load,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildTopCategories(context),
            SizedBox(height: 18),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/search'),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                      child: Row(children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 12),
                        Expanded(child: Text('Search all', style: TextStyle(color: Colors.grey[700]))),
                        Icon(Icons.chevron_right, color: Colors.grey),
                      ]),
                    ),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () async {
                      // open stays search (or show search dialog)
                      Navigator.push(context, MaterialPageRoute(builder: (_) => StaysSearchScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                      child: Row(children: [
                        Icon(Icons.place_outlined, color: Colors.grey),
                        SizedBox(width: 12),
                        Expanded(child: Text(_where.isEmpty ? 'Where to?' : _where, style: TextStyle(fontSize: 16))),
                        Icon(Icons.chevron_right, color: Colors.grey),
                      ]),
                    ),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: _pickDates,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                      child: Row(children: [
                        Icon(Icons.calendar_today_outlined, color: Colors.grey),
                        SizedBox(width: 12),
                        Expanded(child: Text(_dates == null ? 'Dates — Feb 20 - Feb 21' : '${_dates!.start.month}/${_dates!.start.day} - ${_dates!.end.month}/${_dates!.end.day}')),
                        Icon(Icons.chevron_right, color: Colors.grey),
                      ]),
                    ),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: _showPassengers,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
                      child: Row(children: [
                        Icon(Icons.person_outline, color: Colors.grey),
                        SizedBox(width: 12),
                        Expanded(child: Text('${passengers.adults + passengers.children} travelers, ${passengers.infants} infant(s)')),
                        Icon(Icons.chevron_right, color: Colors.grey),
                      ]),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: Row(children: [Checkbox(value: addFlight, onChanged: (v) => setState(() => addFlight = v ?? false)), Text('Add a flight')])),
                    Expanded(child: Row(children: [Checkbox(value: addCar, onChanged: (v) => setState(() => addCar = v ?? false)), Text('Add a car')])),
                  ]),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // save to recent searches and go to hotels
                      history.add(SearchEntry(type: 'stay', query: _where.isNotEmpty ? _where : 'Anywhere'));
                      Navigator.pushNamed(context, '/hotels');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, padding: EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    child: Text('Search', style: TextStyle(fontSize: 16)),
                  )
                ]),
              ),
            ),
            SizedBox(height: 18),
            _buildPromoBanner(),
            SizedBox(height: 18),
            Text(Strings.featuredTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            if (vm.loading) LoadingIndicator(),
            if (vm.error.isNotEmpty) Text(vm.error),
            if (!vm.loading && vm.featured.isNotEmpty)
              SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: vm.featured.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12),
                  itemBuilder: (context, index) => FeaturedHotelCard(hotel: vm.featured[index]),
                ),
              ),
            SizedBox(height: 18),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(Strings.popularTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () => Navigator.pushNamed(context, '/hotels'), child: Text('See all')),
            ]),
            SizedBox(height: 8),
            if (!vm.loading)
              Column(children: vm.popular.map((h) => Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: FeaturedHotelCard(hotel: h, compact: true))).toList()),
            SizedBox(height: 32),
          ]),
        ),
      ),
    );
  }

  Widget _buildTopCategories(BuildContext context) {
    final categories = [
      {'title': 'Stays', 'icon': Icons.bed, 'route': '/stays'},
      {'title': 'Flights', 'icon': Icons.flight, 'route': '/flight_search'},
      {'title': 'Cars', 'icon': Icons.directions_car, 'route': '/cars'},
      {'title': 'Packages', 'icon': Icons.flight_land, 'route': '/deals'},
    ];

    return SizedBox(
      height: 112,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          final c = categories[index];
          return CategoryCard(
            title: c['title'] as String,
            icon: c['icon'] as IconData,
            onTap: () {
              final route = c['route'] as String;
              Navigator.pushNamed(context, route);
            },
          );
        },
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Column(children: [
        Row(children: [
          Icon(Icons.local_offer_outlined, color: Colors.black54),
          SizedBox(width: 12),
          Expanded(child: Text('Your summer of soccer\nSave on match travel across flights, stays, and more.', style: TextStyle(fontWeight: FontWeight.w600))),
        ]),
        SizedBox(height: 8),
        Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: Text('See all deals'))),
      ]),
    );
  }
}