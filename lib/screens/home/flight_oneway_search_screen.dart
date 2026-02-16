import 'package:flutter/material.dart';

// Mock cities for autocomplete
const mockCities = [
  {'name': 'New York (NYC - All Airports)', 'location': 'New York, United States'},
  {'name': 'Atlanta (ATL - Hartsfield-Jackson Atlanta Intl.)', 'location': 'Georgia, United States'},
  {'name': 'Austin (AUS - Austin-Bergstrom Intl.)', 'location': 'Texas, United States'},
  {'name': 'Oranjestad (AUA - Queen Beatrix Intl.)', 'location': 'Aruba'},
  {'name': 'Phoenix (PHX - Sky Harbor Intl.)', 'location': 'Arizona, United States'},
];

class FlightOnewaySearchScreen extends StatefulWidget {
  @override
  State<FlightOnewaySearchScreen> createState() => _FlightOnewaySearchScreenState();
}

class _FlightOnewaySearchScreenState extends State<FlightOnewaySearchScreen> {
  int tripTypeIndex = 1; // 0=Round trip, 1=One-way, 2=Multi-city
  TextEditingController cityCtrl = TextEditingController();
  String? selectedCity;
  bool showAutocomplete = false;

  int adults = 1, children = 0, infantsInSeat = 0, infantsOnLap = 0;
  String cabin = 'Economy';
  final cabinClasses = ['Economy', 'Premium economy', 'Business class', 'First class'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth < 350 ? 10 : 24),
          child: Column(
            children: [
              // Trip type selector (tabs)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _tripTypeTab('Round trip', 0, tripTypeIndex == 0),
                  SizedBox(width: 12),
                  _tripTypeTab('One-way', 1, tripTypeIndex == 1),
                  SizedBox(width: 12),
                  _tripTypeTab('Multi-city', 2, tripTypeIndex == 2),
                ],
              ),
              SizedBox(height: 28),
              // Input and Autocomplete field
              Stack(
                children: [
                  TextField(
                    controller: cityCtrl,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      hintText: 'a',
                      hintStyle: TextStyle(fontSize: 23, color: Colors.black87, letterSpacing: 1),
                      border: InputBorder.none,
                      suffixIcon: cityCtrl.text.isNotEmpty
                          ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.black, size: 24),
                        onPressed: () {
                          setState(() {
                            cityCtrl.clear();
                            showAutocomplete = false;
                            selectedCity = null;
                          });
                        },
                      )
                          : null,
                    ),
                    onChanged: (val) {
                      setState(() {
                        showAutocomplete = val.isNotEmpty;
                      });
                    },
                  ),
                  // Autocomplete suggestion popup
                  if (showAutocomplete)
                    Positioned(
                      top: 48,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: mockCities
                              .where((m) =>
                              m['name']!.toLowerCase().contains(cityCtrl.text.toLowerCase()))
                              .map((city) => ListTile(
                            onTap: () {
                              setState(() {
                                cityCtrl.text = city['name']!;
                                selectedCity = city['name'];
                                showAutocomplete = false;
                              });
                            },
                            leading: Icon(Icons.location_on_outlined,
                                color: Colors.black, size: 24),
                            title: Text(city['name']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                )),
                            subtitle: Text(city['location'] ?? '',
                                style: TextStyle(fontSize: 14)),
                          ))
                              .toList(),
                        ),
                        // Add shadow to match Expedia UI
                      ),
                    ),
                ],
              ),
              SizedBox(height: showAutocomplete ? 210 : 34),
              // Travelers + Cabin Selector
              Row(
                children: [
                  Expanded(
                    child: _travelersSelector(
                      label: 'Travelers',
                      adults: adults,
                      children: children,
                      infantsLap: infantsOnLap,
                      infantsSeat: infantsInSeat,
                      onChanged: (a, c, s, l) {
                        setState(() {
                          adults = a;
                          children = c;
                          infantsInSeat = s;
                          infantsOnLap = l;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: cabin,
                          items: cabinClasses
                              .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          ))
                              .toList(),
                          onChanged: (v) => setState(() => cabin = v ?? cabin),
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 38),
              // Search button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 19),
                    backgroundColor: Color(0xFF266CFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    textStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    // Implement navigation to results
                  },
                  child: Text('Search flights'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tripTypeTab(String title, int idx, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => tripTypeIndex = idx),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFF2F6FF) : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isSelected ? Color(0xFF266CFF) : Color(0xFFE5E7EB),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Color(0xFF266CFF) : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 16.2,
          ),
        ),
      ),
    );
  }

  Widget _travelersSelector({
    required String label,
    required int adults,
    required int children,
    required int infantsLap,
    required int infantsSeat,
    required Function(int, int, int, int) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: Colors.black54)),
        SizedBox(height: 7),
        Row(
          children: [
            _numberCircle(adults, 'A', () => onChanged(adults + 1, children, infantsSeat, infantsLap),
                    () => onChanged(adults - 1 >= 1 ? adults - 1 : 1, children, infantsSeat, infantsLap)),
            SizedBox(width: 4),
            _numberCircle(children, 'C', () => onChanged(adults, children + 1, infantsSeat, infantsLap),
                    () => onChanged(adults, children - 1 >= 0 ? children - 1 : 0, infantsSeat, infantsLap)),
            SizedBox(width: 4),
            _numberCircle(infantsSeat, 'IS',
                    () => onChanged(adults, children, infantsSeat + 1, infantsLap),
                    () => onChanged(adults, children, infantsSeat - 1 >= 0 ? infantsSeat - 1 : 0, infantsLap)),
            SizedBox(width: 4),
            _numberCircle(infantsLap, 'IL',
                    () => onChanged(adults, children, infantsSeat, infantsLap + 1),
                    () => onChanged(adults, children, infantsSeat, infantsLap - 1 >= 0 ? infantsLap - 1 : 0)),
          ],
        ),
      ],
    );
  }

  Widget _numberCircle(int value, String label, VoidCallback onAdd, VoidCallback onRemove) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey)),
        Row(
          children: [
            InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade400),
                  color: Colors.white,
                ),
                child: Icon(Icons.remove, size: 17, color: Colors.black87),
              ),
            ),
            SizedBox(width: 3),
            Container(
              width: 30,
              height: 27,
              alignment: Alignment.center,
              child: Text('$value',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            SizedBox(width: 3),
            InkWell(
              onTap: onAdd,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF266CFF)),
                  color: Color(0xFFF2F6FF),
                ),
                child: Icon(Icons.add, size: 17, color: Color(0xFF266CFF)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}