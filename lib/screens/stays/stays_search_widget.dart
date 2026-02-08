import 'package:flutter/material.dart';

class StaysSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(22),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Stays Search", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(hintText: "Where to?", prefixIcon: Icon(Icons.place_outlined)),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: TextField(
                      decoration: InputDecoration(hintText: "Check-in", prefixIcon: Icon(Icons.calendar_today)),
                    )),
                    SizedBox(width: 8),
                    Expanded(child: TextField(
                      decoration: InputDecoration(hintText: "Check-out", prefixIcon: Icon(Icons.calendar_today)),
                    )),
                  ],
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(hintText: "Travelers", prefixIcon: Icon(Icons.person_outline)),
                ),
                SizedBox(height: 18),
                ElevatedButton(onPressed: () {}, child: Text("Search")),
              ],
            ),
          ),
        ),
        SizedBox(height: 18),
        _promoBanner(),
      ],
    );
  }

  Widget _promoBanner() => Container(
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
            Expanded(child: Text("Your summer of soccer\nSave on match travel across flights, stays, and more.", style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        SizedBox(height:8),
        GestureDetector(
          child: Text('See all deals', style: TextStyle(color: Color(0xFF266CFF), fontWeight: FontWeight.w600)),
          onTap: () {},
        ),
      ],
    ),
  );
}