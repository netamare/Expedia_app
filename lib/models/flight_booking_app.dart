import 'package:flutter/material.dart';

void main() => runApp(FlightBookingDemoApp());

class FlightBookingDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expedia Flight Booking",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF266CFF),
        fontFamily: 'sans-serif',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF266CFF),
        ),
      ),
      home: MainFlightSearchPage(),
    );
  }
}

// --------------- MOCK CITY DATA --------------
class City {
  final String name, code, country;
  City(this.name, this.code, this.country);
}

final List<City> mockCities = [
  City("New York", "NYC", "United States"),
  City("Atlanta", "ATL", "United States"),
  City("Austin", "AUS", "United States"),
  City("Oranjestad", "AUA", "Aruba"),
  City("Phoenix", "PHX", "United States"),
  City("Addis Ababa", "ADD", "Ethiopia"),
];

// --------------- MAIN FLIGHT SEARCH PAGE ---------------
class MainFlightSearchPage extends StatefulWidget {
  @override
  State<MainFlightSearchPage> createState() => _MainFlightSearchPageState();
}

class _MainFlightSearchPageState extends State<MainFlightSearchPage> {
  int mainTabIndex = 1;    // 0=Stays, 1=Flights, 2=Cars, 3=Packages
  int flightTabIndex = 1;  // 0=Roundtrip, 1=One-way, 2=Multi-city

  City? fromCity;
  City? toCity;
  DateTime? selectedDate = DateTime(2026, 2, 28);
  int adults = 1, children = 0, infantsSeat = 0, infantsLap = 0;
  String cabinClass = "Economy";

  void pickCity(bool isFrom) async {
    final result = await Navigator.push(context, MaterialPageRoute(
      builder: (_) => CitySearchPage(),
    ));
    if (result is City) {
      setState(() {
        if (isFrom) {
          fromCity = result;
        } else {
          toCity = result;
        }
      });
    }
  }

  void showTravelerPage() async {
    final result = await Navigator.push(context, MaterialPageRoute(
      builder: (_) => TravelersCabinPage(
        adults: adults, children: children,
        infantsLap: infantsLap, infantsSeat: infantsSeat,
        cabin: cabinClass,
      ),
    ));
    if (result is Map) {
      setState(() {
        adults = result['adults'];
        children = result['children'];
        infantsLap = result['infantsLap'];
        infantsSeat = result['infantsSeat'];
        cabinClass = result['cabin'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bg = Colors.white;
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // -------- TOP BAR with Stays / Flights / Cars / Packages
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 16, left: 0, right: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ["Stays", "Flights", "Cars", "Packages"]
                      .asMap().entries.map((e) =>
                      GestureDetector(
                        onTap: () => setState(() => mainTabIndex = e.key),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                          decoration: BoxDecoration(
                            border: mainTabIndex == e.key
                                ? Border(
                              bottom: BorderSide(
                                color: Color(0xFF266CFF),
                                width: 3,
                              ),
                            )
                                : null,
                          ),
                          child: Text(
                            e.value,
                            style: TextStyle(
                              color: mainTabIndex == e.key ? Color(0xFF266CFF) : Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.5,
                            ),
                          ),
                        ),
                      )).toList(),
                ),
              ),
              Divider(height: 0, thickness: 1.1),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ["Roundtrip", "One-way", "Multi-city"]
                      .asMap().entries.map((e) =>
                      GestureDetector(
                        onTap: () => setState(() => flightTabIndex = e.key),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: flightTabIndex == e.key
                                    ? Color(0xFF266CFF) : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Text(
                            e.value,
                            style: TextStyle(
                              color:
                              flightTabIndex == e.key ? Color(0xFF266CFF) : Colors.black54,
                              fontWeight:
                              flightTabIndex == e.key ? FontWeight.w700 : FontWeight.w400,
                              fontSize: 15.8,
                            ),
                          ),
                        ),
                      )
                  ).toList(),
                ),
              ),
              // ------------ Main form fields
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 19, vertical: 11),
                child: Column(
                  children: [
                    // ---- Leaving from
                    _expediaInputField(
                      label: 'Leaving from',
                      value: fromCity != null
                          ? "${fromCity!.name} (${fromCity!.code}-Bole Intl.)"
                          : "",
                      hint: "Leaving from",
                      icon: Icons.location_on_outlined,
                      onTap: () => pickCity(true),
                    ),
                    // SWAP BUTTON
                    Align(
                      alignment: Alignment.centerRight,
                      child: Transform.translate(
                        offset: Offset(0, -30),
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
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.swap_vert, size: 30, color: Colors.black87),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ---- Going to
                    _expediaInputField(
                      label: 'Going to',
                      value: toCity != null ? "${toCity!.name} (${toCity!.code})" : "",
                      hint: "Going to",
                      icon: Icons.location_on_outlined,
                      onTap: () => pickCity(false),
                    ),
                    // ---- Date
                    _expediaInputField(
                      label: 'Date',
                      value: selectedDate != null
                          ? _formatDate(selectedDate!)
                          : "",
                      hint: "Date",
                      icon: Icons.calendar_today,
                      onTap: () async {
                        final now = DateTime.now();
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? now,
                          firstDate: now,
                          lastDate: now.add(Duration(days: 365)),
                        );
                        if (picked != null) setState(() => selectedDate = picked);
                      },
                    ),
                    // ---- Travelers/Cabin
                    _expediaInputField(
                      label: 'Travelers, Cabin class',
                      value: _travelerSummary(adults, children, infantsSeat, infantsLap, cabinClass),
                      hint: "1 traveler, Economy",
                      icon: Icons.person_outline,
                      onTap: showTravelerPage,
                    ),
                    // ---- Search Button
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 17),
                          backgroundColor: Color(0xFF266CFF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {},
                        child: Text('Search'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              // Promo Banner example (can remove)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                color: Color(0xFF192C54),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 19),
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.sell, color: Color(0xFF266CFF)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Annual Vacation Sale",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                          SizedBox(height: 2),
                          Text("Members save up to 40% on select hotels and homes.",
                              style: TextStyle(color: Colors.white, fontSize: 13)),
                          Text("Book now", style: TextStyle(color: Color(0xFF92c6FF), fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Example bottom nav
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Color(0xFF266CFF),
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.card_travel), label: "Trips"),
          BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: "Inbox"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Account"),
        ],
      ),
    );
  }
}

// Helper for Expedia-style input field
Widget _expediaInputField({
  required String label,
  required String value,
  required String hint,
  required IconData icon,
  required VoidCallback onTap,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        behavior: value.isEmpty ? HitTestBehavior.opaque : HitTestBehavior.translucent,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFE9EAEC), width: 1.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, size: 24, color: Colors.black54),
              SizedBox(width: 14),
              Expanded(
                child: value.isEmpty
                    ? Text(hint, style: TextStyle(color: Colors.black45, fontSize: 16.7))
                    : Text(value, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );

// Format "Sat, Feb 28"
String _formatDate(DateTime d) {
  final weekday = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][d.weekday - 1];
  return "$weekday, ${_month(d.month)} ${d.day}";
}

String _month(int m) =>
    ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][m - 1];

String _travelerSummary(int a, int c, int s, int l, String cc) {
  final total = a + c + s + l;
  return "$total traveler${total > 1 ? "s" : ""}, $cc";
}

// ------------ CITY SEARCH PAGE -------------
class CitySearchPage extends StatefulWidget {
  @override
  State<CitySearchPage> createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {
  TextEditingController ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final filtered = ctrl.text.isEmpty
        ? mockCities
        : mockCities
        .where((c) =>
    c.name.toLowerCase().contains(ctrl.text.toLowerCase()) ||
        c.code.toLowerCase().contains(ctrl.text.toLowerCase()))
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: SizedBox(),
      ),
      body: Column(
        children: [
          SizedBox(height: 28),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close, size: 29),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    autofocus: true,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "a",
                      hintStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                if (ctrl.text.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      ctrl.clear();
                      setState(() {});
                    },
                  ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => SizedBox(height: 7),
              itemBuilder: (ctx, i) {
                final c = filtered[i];
                return ListTile(
                  leading: Icon(Icons.location_on_outlined, color: Colors.black, size: 23),
                  title: Text(
                    "${c.name} (${c.code == 'NYC' ? 'All Airports' : c.code})",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.7),
                  ),
                  subtitle: Text(
                    c.country,
                    style: TextStyle(fontSize: 13.8),
                  ),
                  onTap: () => Navigator.pop(context, c),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ------------ TRAVELERS + CABIN PAGE -------------

class TravelersCabinPage extends StatefulWidget {
  final int adults, children, infantsLap, infantsSeat;
  final String cabin;

  TravelersCabinPage({
    required this.adults,
    required this.children,
    required this.infantsLap,
    required this.infantsSeat,
    required this.cabin,
  });

  @override
  State<TravelersCabinPage> createState() => _TravelersCabinPageState();
}

class _TravelersCabinPageState extends State<TravelersCabinPage> {
  late int adults, children, infantsLap, infantsSeat;
  late String cabin;

  @override
  void initState() {
    super.initState();
    adults = widget.adults;
    children = widget.children;
    infantsLap = widget.infantsLap;
    infantsSeat = widget.infantsSeat;
    cabin = widget.cabin;
  }

  @override
  Widget build(BuildContext context) {
    const cabinClasses = ["Economy", "Business", "First"];
    Widget row(String label, String desc, int value, VoidCallback incr, VoidCallback decr) =>
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
          child: Row(
            children: [
              SizedBox(
                width: 128,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                    if (desc.isNotEmpty)
                      Text(desc, style: TextStyle(fontSize: 12.5, color: Colors.black54)),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.remove_circle_outline, size: 29),
                onPressed: decr,
              ),
              Text(
                "$value",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline, size: 29),
                onPressed: incr,
              ),
            ],
          ),
        );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Travelers and Cabin class",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19)),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 4),
          row("Adults", "", adults,
                  () => setState(() => adults++),
                  () => setState(() => adults = adults > 1 ? adults - 1 : 1)),
          row("Children", "Ages 2 to 17", children,
                  () => setState(() => children++),
                  () => setState(() => children = children > 0 ? children - 1 : 0)),
          row("Infants in seat", "Younger than 2", infantsSeat,
                  () => setState(() => infantsSeat++),
                  () => setState(() => infantsSeat = infantsSeat > 0 ? infantsSeat - 1 : 0)),
          row("Infants on lap", "Younger than 2", infantsLap,
                  () => setState(() => infantsLap++),
                  () => setState(() => infantsLap = infantsLap > 0 ? infantsLap - 1 : 0)),
          SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: "Cabin class",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: cabin,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                  items: cabinClasses.map((c) => DropdownMenuItem(
                    value: c, child: Text(c),
                  )).toList(),
                  onChanged: (v) => setState(() => cabin = v ?? cabin),
                ),
              ),
            ),
          ),
          Spacer(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Color(0xFF266CFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'adults': adults,
                    'children': children,
                    'infantsLap': infantsLap,
                    'infantsSeat': infantsSeat,
                    'cabin': cabin,
                  });
                },
                child: const Center(
                  child: Text("Done", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
