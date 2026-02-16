import 'package:flutter/material.dart';
// import '../../data/cities_data.dart';
// import 'city_search_page.dart';
import 'models/flight_booking_app.dart';
// import 'travelers_cabin_page.dart';

class FlightBookingMainPage extends StatefulWidget {
  @override
  State<FlightBookingMainPage> createState() => _FlightBookingMainPageState();
}

class _FlightBookingMainPageState extends State<FlightBookingMainPage> {
  int flightTab = 1; // 1 = One-way selected
  City? fromCity;
  City? toCity;
  DateTime? date = DateTime(2026, 2, 28);
  int adults = 1, children = 0, infantsSeat = 0, infantsLap = 0;
  String cabin = "Economy";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xFF266CFF),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                child: Row(
                  children: [
                    Icon(Icons.flight_takeoff, color: Colors.yellow[700], size: 29),
                    SizedBox(width: 8),
                    Text("Expedia", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19)),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 12),
                      child: Text("Blue", style: TextStyle(color: Color(0xFF266CFF), fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 9),
                    Text("\$15.00 in OneKeyCash", style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
              SizedBox(height: 8),

              // App navigation tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _mainTab("Stays", 0),
                  _mainTab("Flights", 1, selected: true),
                  _mainTab("Cars", 2),
                  _mainTab("Packages", 3),
                ],
              ),
              SizedBox(height: 2),

              // Flight tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _flightTab("Roundtrip", 0),
                  _flightTab("One-way", 1, selected: true),
                  _flightTab("Multi-city", 2),
                ],
              ),
              SizedBox(height: 18),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                child: Container(
                  padding: EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 25, offset: Offset(2, 11), spreadRadius: -19),
                    ],
                  ),
                  child: Column(
                    children: [
                      _inputField(
                        label: "Leaving from",
                        value: fromCity == null ? "Select city"
                            : "${fromCity!.name} (${fromCity!.code}-Bole Intl.)",
                        icon: Icons.location_on_outlined,
                        onTap: () async {
                          final result = await Navigator.push(context, MaterialPageRoute(
                            builder: (_) => CitySearchPage(),
                          ));
                          if (result is City) setState(() => fromCity = result);
                        },
                      ),

                      // SWAP button
                      Align(
                        alignment: Alignment.centerRight,
                        child: Transform.translate(
                          offset: Offset(0, -32),
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(21),
                            elevation: 1.5,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(21),
                              onTap: () {
                                setState(() {
                                  final temp = fromCity;
                                  fromCity = toCity;
                                  toCity = temp;
                                });
                              },
                              child: Container(
                                width: 42, height: 42,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade200),
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.swap_vert, size: 29, color: Colors.black87),
                              ),
                            ),
                          ),
                        ),
                      ),

                      _inputField(
                        label: "Going to",
                        value: toCity == null ? "Select city" : "${toCity!.name} (${toCity!.code})",
                        icon: Icons.location_on_outlined,
                        onTap: () async {
                          final result = await Navigator.push(context, MaterialPageRoute(
                            builder: (_) => CitySearchPage(),
                          ));
                          if (result is City) setState(() => toCity = result);
                        },
                      ),
                      SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: _inputField(
                              label: "Date",
                              value: "${date?.month}/${date?.day}/${date?.year}",
                              icon: Icons.calendar_today,
                              onTap: () async {
                                final now = DateTime.now();
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: date ?? now,
                                  firstDate: now,
                                  lastDate: now.add(Duration(days: 365)),
                                );
                                if (picked != null) setState(() => date = picked);
                              },
                              small: true,
                            ),
                          ),
                          SizedBox(width: 13),
                          Expanded(
                            child: _inputField(
                              label: "Travelers, Cabin class",
                              value: "${adults + children + infantsLap + infantsSeat} traveler${adults+children+infantsLap+infantsSeat > 1 ? "s" : ""}, $cabin",
                              icon: Icons.person_outline,
                              onTap: () async {
                                final result = await Navigator.push(context, MaterialPageRoute(
                                    builder: (_) => TravelersCabinPage(
                                      adults: adults, children: children,
                                      infantsLap: infantsLap, infantsSeat: infantsSeat,
                                      cabin: cabin,
                                    )));
                                if (result is Map) setState(() {
                                  adults = result['adults'];
                                  children = result['children'];
                                  infantsLap = result['infantsLap'];
                                  infantsSeat = result['infantsSeat'];
                                  cabin = result['cabin'];
                                });
                              },
                              small: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Color(0xFF266CFF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
                            textStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                          child: Text("Search"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainTab(String title, int idx, {bool selected = false}) => Column(
    children: [
      SizedBox(height: 2),
      Icon(
        title == "Stays" ? Icons.bed_outlined
            : title == "Flights" ? Icons.flight
            : title == "Cars" ? Icons.directions_car
            : Icons.card_travel,
        color: selected ? Color(0xFF266CFF) : Colors.black54,
        size: 24,
      ),
      SizedBox(height: 2),
      Text(
        title,
        style: TextStyle(
            color: selected ? Color(0xFF266CFF) : Colors.black87,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14
        ),
      ),
    ],
  );

  Widget _flightTab(String title, int idx, {bool selected = false}) => GestureDetector(
    onTap: () => setState(() => flightTab = idx),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      margin: EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: flightTab == idx ? Color(0xFF266CFF) : Colors.transparent,
              width: 3
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: flightTab == idx ? Color(0xFF266CFF) : Colors.black54,
          fontWeight: flightTab == idx ? FontWeight.bold : FontWeight.w400,
          fontSize: 16.3,
        ),
      ),
    ),
  );

  Widget _inputField({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
    bool small = false
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: small ? 1.5 : 7.5),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: small ? 11 : 19),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Color(0xFFE8EAF0), width: 1.3),
          ),
          child: Row(
            children: [
              Icon(icon, size: small ? 21 : 26, color: Colors.black54),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: TextStyle(fontSize: small ? 12.5 : 14.5, color: Colors.black45)),
                    SizedBox(height: 2),
                    Text(value,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: small ? 15.3 : 17.3,
                            color: value == "Select city" ? Colors.black38 : Colors.black87
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}