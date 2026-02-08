import 'package:flutter/material.dart';

class ExpediaFlightSearchTab extends StatefulWidget {
  @override
  State<ExpediaFlightSearchTab> createState() => _ExpediaFlightSearchTabState();
}

class _ExpediaFlightSearchTabState extends State<ExpediaFlightSearchTab>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  // Controllers for roundtrip/oneway
  final TextEditingController _fromCtrl = TextEditingController(text: "Addis Ababa (ADD-Bole Intl.)");
  final TextEditingController _toCtrl = TextEditingController();
  final TextEditingController _dateCtrl = TextEditingController(text: "Sun, Feb 22");
  final TextEditingController _returnDateCtrl = TextEditingController(text: "Mon, Feb 23");

  // Multi-city state
  List<Map<String, TextEditingController>> _multiCityFlights = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _multiCityFlights = List.generate(2, (i) => {
      'from': TextEditingController(),
      'to': TextEditingController(),
      'date': TextEditingController(text: "Sun, Feb 22"),
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _fromCtrl.dispose();
    _toCtrl.dispose();
    _dateCtrl.dispose();
    _returnDateCtrl.dispose();
    for (var flight in _multiCityFlights) {
      flight['from']!.dispose();
      flight['to']!.dispose();
      flight['date']!.dispose();
    }
    super.dispose();
  }

  Widget _tripForm({bool oneWay = false}) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      children: [
        _inputField("Leaving from", Icons.location_on, _fromCtrl),
        SizedBox(height: 10),
        _inputField("Going to", Icons.location_on, _toCtrl),
        SizedBox(height: 10),
        if (oneWay)
          _inputField("Date", Icons.calendar_today, _dateCtrl, readOnly: true, onTap: () {/* Show picker here */}),
        if (!oneWay)
          Row(
            children: [
              Expanded(
                child: _inputField("Depart", Icons.calendar_today, _dateCtrl, readOnly: true, onTap: () {/* Show picker here */}),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _inputField("Return", Icons.calendar_today, _returnDateCtrl, readOnly: true, onTap: () {/* Show picker here */}),
              ),
            ],
          ),
        SizedBox(height: 10),
        _travelerCabinWidget(),
        SizedBox(height: 18),
        ElevatedButton(
          onPressed: () {}, // Do search
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF266CFF),
              minimumSize: Size(double.infinity, 56),
              shape: StadiumBorder()),
          child: Text("Search", style: TextStyle(fontSize: 18)),
        ),
        SizedBox(height: 18),
        _promoBanner()
      ],
    );
  }

  Widget _inputField(
      String label, IconData icon, TextEditingController controller,
      {bool readOnly = false, VoidCallback? onTap}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFF266CFF)),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      readOnly: readOnly,
      onTap: onTap,
    );
  }

  Widget _multiCityForm() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      children: [
        _travelerCabinWidget(),
        SizedBox(height: 4),
        for (int i = 0; i < _multiCityFlights.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Color(0x11000000), blurRadius: 5)],
              ),
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    Text('Flight ${i + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
                    Spacer(),
                    if (_multiCityFlights.length > 2)
                      IconButton(
                          icon: Icon(Icons.close, size: 19, color: Colors.red),
                          tooltip: "Remove",
                          onPressed: () {
                            setState(() => _multiCityFlights.removeAt(i));
                          }),
                  ]),
                  _inputField("Leaving from", Icons.location_on, _multiCityFlights[i]['from']!),
                  SizedBox(height: 8),
                  _inputField("Going to", Icons.location_on, _multiCityFlights[i]['to']!),
                  SizedBox(height: 8),
                  _inputField("Date", Icons.calendar_today, _multiCityFlights[i]['date']!, readOnly: true, onTap: () {/* picker */}),
                ],
              ),
            ),
          ),
        SizedBox(height: 7),
        (_multiCityFlights.length < 6)
            ? TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFF266CFF),
          ),
          icon: Icon(Icons.add),
          label: Text("Add flight"),
          onPressed: () {
            setState(() {
              _multiCityFlights.add({
                'from': TextEditingController(),
                'to': TextEditingController(),
                'date': TextEditingController(),
              });
            });
          },
        )
            : SizedBox.shrink(),
        SizedBox(height: 18),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF266CFF),
              minimumSize: Size(double.infinity, 56),
              shape: StadiumBorder()),
          child: Text("Search", style: TextStyle(fontSize: 18)),
        ),
        SizedBox(height: 18),
        _promoBanner(),
      ],
    );
  }

  Widget _travelerCabinWidget() => Card(
    elevation: 0,
    color: Color(0xfff5f6ff),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      leading: Icon(Icons.person, color: Color(0xFF266CFF)),
      title: Text("Travelers, Cabin class"),
      subtitle: Text("1 traveler, Economy"),
      contentPadding: EdgeInsets.all(0),
    ),
  );

  Widget _promoBanner() => Container(
    margin: EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      color: Color(0xFFEFF6FF),
    ),
    padding: EdgeInsets.all(19),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.local_offer_outlined, color: Colors.blue.shade900),
            SizedBox(width: 12),
            Expanded(
                child: Text(
                    "Your summer of soccer\nSave on match travel across flights, stays, and more.",
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        SizedBox(height: 8),
        GestureDetector(
          child: Text('See all deals',
              style: TextStyle(
                  color: Color(0xFF266CFF), fontWeight: FontWeight.w600)),
          onTap: () {},
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _controller,
          indicatorColor: Color(0xFF266CFF),
          labelColor: Color(0xFF266CFF),
          unselectedLabelColor: Colors.black45,
          tabs: const [
            Tab(text: "Roundtrip"),
            Tab(text: "One-way"),
            Tab(text: "Multi-city"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: [
              _tripForm(),
              _tripForm(oneWay: true),
              _multiCityForm(),
            ],
          ),
        ),
      ],
    );
  }
}