import 'package:flutter/material.dart';
import 'data.dart';

class TravelersPage extends StatefulWidget {
  final int adults;
  final int children;
  final int infantsSeat;
  final int infantsLap;
  final String cabin;

  const TravelersPage({
    Key? key,
    required this.adults,
    required this.children,
    required this.infantsSeat,
    required this.infantsLap,
    required this.cabin,
  }) : super(key: key);

  @override
  State<TravelersPage> createState() => _TravelersPageState();
}

class _TravelersPageState extends State<TravelersPage> {
  late int adults;
  late int children;
  late int infantsSeat;
  late int infantsLap;
  late String cabin;

  @override
  void initState() {
    super.initState();
    adults = widget.adults;
    children = widget.children;
    infantsSeat = widget.infantsSeat;
    infantsLap = widget.infantsLap;
    cabin = widget.cabin;
  }

  void updateValue(String type, int delta) {
    setState(() {
      switch (type) {
        case "adults":
          adults = (adults + delta).clamp(1, 9);
          break;
        case "children":
          children = (children + delta).clamp(0, 8);
          break;
        case "infantsSeat":
          infantsSeat = (infantsSeat + delta).clamp(0, 8);
          break;
        case "infantsLap":
          infantsLap = (infantsLap + delta).clamp(0, 8);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget travelerRow(String label, String desc, String type, int value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ]),
          Row(
            children: [
              IconButton(
                  onPressed: () => updateValue(type, -1),
                  icon: const Icon(Icons.remove_circle_outline)),
              Text('$value', style: const TextStyle(fontSize: 18)),
              IconButton(
                  onPressed: () => updateValue(type, 1),
                  icon: const Icon(Icons.add_circle_outline)),
            ],
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.close, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Travelers and Cabin class",
            style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                travelerRow("Adults", "Ages 18+", "adults", adults),
                travelerRow("Children", "Ages 2 to 17", "children", children),
                travelerRow(
                    "Infants in seat", "Younger than 2", "infantsSeat", infantsSeat),
                travelerRow(
                    "Infants on lap", "Younger than 2", "infantsLap", infantsLap),
                const SizedBox(height: 30),
                InputDecorator(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: cabin,
                      onChanged: (v) => setState(() => cabin = v ?? cabin),
                      isExpanded: true,
                      items: cabinClasses
                          .map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(c),
                      ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'adults': adults,
                    'children': children,
                    'infantsSeat': infantsSeat,
                    'infantsLap': infantsLap,
                    'cabin': cabin,
                  });
                },
                child: const Text("Done", style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}