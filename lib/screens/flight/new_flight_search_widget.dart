import 'package:flutter/material.dart';

class NewFlightSearchWidget extends StatefulWidget {
  @override
  State<NewFlightSearchWidget> createState() => _NewFlightSearchWidgetState();
}

class _NewFlightSearchWidgetState extends State<NewFlightSearchWidget> with SingleTickerProviderStateMixin {
  late TabController _modeController;
  int routeCount = 2;
  List<TextEditingController> fromControllers = [];
  List<TextEditingController> toControllers = [];

  @override
  void initState() {
    super.initState();
    _modeController = TabController(length: 3, vsync: this);
    fromControllers = List.generate(3, (i) => TextEditingController());
    toControllers = List.generate(3, (i) => TextEditingController());
  }

  @override
  void dispose() {
    _modeController.dispose();
    fromControllers.forEach((c) => c.dispose());
    toControllers.forEach((c) => c.dispose());
    super.dispose();
  }

  Widget oneWayUI() => Column(
    children: [
      TextField(
        controller: fromControllers[0],
        decoration: InputDecoration(labelText: 'From'),
      ),
      SizedBox(height: 8),
      TextField(
        controller: toControllers[0],
        decoration: InputDecoration(labelText: 'To'),
      ),
      SizedBox(height: 8),
      ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text('Date'),
        subtitle: Text('Select departure date'),
        onTap: () {},
      ),
    ],
  );

  Widget roundTripUI() => Column(
    children: [
      TextField(
        controller: fromControllers[0],
        decoration: InputDecoration(labelText: 'From'),
      ),
      SizedBox(height: 8),
      TextField(
        controller: toControllers[0],
        decoration: InputDecoration(labelText: 'To'),
      ),
      SizedBox(height: 8),
      ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text('Dates'),
        subtitle: Text('Select departure & return dates'),
        onTap: () {},
      ),
    ],
  );

  Widget multiCityUI() => Column(
    children: [
      ...List.generate(routeCount, (i) => Column(
        children: [
          Row(
            children: [
              Expanded(child: TextField(controller: fromControllers[i], decoration: InputDecoration(labelText: 'From'))),
              SizedBox(width: 6),
              Expanded(child: TextField(controller: toControllers[i], decoration: InputDecoration(labelText: 'To'))),
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: routeCount > 1 ? () {
                  setState(() {
                    if (routeCount > 1) routeCount--;
                  });
                } : null,
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      )),
      ElevatedButton(
        onPressed: () { setState(() { if (routeCount < 3) routeCount++; }); },
        child: Text('Add segment'),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TabBar(
        controller: _modeController,
        tabs: [
          Tab(text: 'Roundtrip'),
          Tab(text: 'One-way'),
          Tab(text: 'Multi-city'),
        ],
        labelColor: Colors.blue,
      ),
      Expanded(
        child: TabBarView(
          controller: _modeController,
          children: [
            roundTripUI(),
            oneWayUI(),
            multiCityUI(),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Search'),
        ),
      ),
    ]);
  }
}