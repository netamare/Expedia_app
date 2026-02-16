import 'package:flutter/material.dart';
import 'data.dart';
import 'flight_result_page.dart';
import 'models.dart';
import 'travelers_page.dart';

class FlightSearchPage extends StatefulWidget {
  const FlightSearchPage({Key? key}) : super(key: key);

  @override
  State<FlightSearchPage> createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  final TextEditingController fromCtrl = TextEditingController();
  final TextEditingController toCtrl = TextEditingController();

  City? selectedFrom;
  City? selectedTo;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 7));
  int adults = 1, children = 0, infantsLap = 0, infantsSeat = 0;
  String cabin = 'Economy';

  // Used for autocomplete
  List<City> autocompleteCities(String query) => [
    ...cities.where((c) =>
        c.displayName.toLowerCase().contains(query.toLowerCase()))
  ];

  Widget cityAutocompleteField({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<City> onSelected,
    City? selectedCity,
  }) {
    return Autocomplete<City>(
      displayStringForOption: (City option) => option.displayName,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<City>.empty();
        }
        return autocompleteCities(textEditingValue.text);
      },
      onSelected: onSelected,
      initialValue: selectedCity != null
          ? TextEditingValue(text: selectedCity.displayName)
          : null,
      fieldViewBuilder:
          (context, controllerOverride, focusNode, onEditingComplete) {
        return TextField(
          controller: controllerOverride,
          focusNode: focusNode,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: controllerOverride.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  controllerOverride.clear();
                });
              },
            )
                : null,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(fontSize: 18),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Material(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: options
                .map((city) => ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: Text(city.displayName),
              subtitle:
              Text('${city.region != '' ? city.region + ', ' : ''}${city.country}'),
              onTap: () => onSelected(city),
            ))
                .toList(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    fromCtrl.dispose();
    toCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double space = 16;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.close, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Book a flight', style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('From', style: TextStyle(color: Colors.grey.shade700)),
          cityAutocompleteField(
            controller: fromCtrl,
            hint: 'Departure city',
            selectedCity: selectedFrom,
            onSelected: (city) {
              setState(() {
                selectedFrom = city;
                fromCtrl.text = city.displayName;
              });
            },
          ),
          SizedBox(height: space),
          Text('To', style: TextStyle(color: Colors.grey.shade700)),
          cityAutocompleteField(
            controller: toCtrl,
            hint: 'Destination city',
            selectedCity: selectedTo,
            onSelected: (city) {
              setState(() {
                selectedTo = city;
                toCtrl.text = city.displayName;
              });
            },
          ),
          SizedBox(height: space),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (result != null) {
                      setState(() => selectedDate = result);
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      label: Text('Departure date'),
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(width: space),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TravelersPage(
                          adults: adults,
                          children: children,
                          infantsLap: infantsLap,
                          infantsSeat: infantsSeat,
                          cabin: cabin,
                        ),
                      ),
                    );
                    if (result != null && result is Map) {
                      setState(() {
                        adults = result['adults'];
                        children = result['children'];
                        infantsLap = result['infantsLap'];
                        infantsSeat = result['infantsSeat'];
                        cabin = result['cabin'];
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      label: Text('Travelers, Cabin'),
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      '$adults traveler${adults > 1 ? "s" : ""}, $cabin',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: space * 2),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.blue,
              ),
              onPressed: (selectedFrom != null && selectedTo != null)
                  ? () {
                // Normally send data, now just go to mock results
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FlightResultsPage(
                      fromCity: selectedFrom!,
                      toCity: selectedTo!,
                      date: selectedDate,
                      adults: adults,
                      cabin: cabin,
                    ),
                  ),
                );
              }
                  : null,
              child: const Text("Search flights", style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}