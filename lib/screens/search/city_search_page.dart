import 'package:flutter/material.dart';
import '../../data/cities_data.dart';
// import '../../data/cities_data.dart';

class CitySearchPage extends StatefulWidget {
  @override
  State<CitySearchPage> createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {
  TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final input = ctrl.text.toLowerCase();
    // Prioritize cities that start with input, then those that contain it
    final startsWithMatches = input.isEmpty
        ? mockCities
        : mockCities
        .where((c) =>
    c.name.toLowerCase().startsWith(input) ||
        c.code.toLowerCase().startsWith(input))
        .toList();

    final containsMatches = input.isEmpty
        ? []
        : mockCities
        .where((c) =>
    !(c.name.toLowerCase().startsWith(input) ||
        c.code.toLowerCase().startsWith(input)) &&
        (c.name.toLowerCase().contains(input) ||
            c.code.toLowerCase().contains(input)))
        .toList();

    final filtered = [...startsWithMatches, ...containsMatches];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: SizedBox()),
      body: Column(
        children: [
          SizedBox(height: 28),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close, size: 27),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    autofocus: true,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "a",
                      hintStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
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
                  )
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(left: 22, right: 22, top: 14),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => SizedBox(height: 6),
              itemBuilder: (ctx, i) {
                final c = filtered[i];
                return ListTile(
                  leading: Icon(Icons.location_on_outlined, color: Colors.black, size: 23),
                  title: Text(
                    "${c.name} (${c.code})",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.3),
                  ),
                  subtitle: Text(c.country, style: TextStyle(fontSize: 13.5)),
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