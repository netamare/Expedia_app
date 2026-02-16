import 'package:flutter/material.dart';

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