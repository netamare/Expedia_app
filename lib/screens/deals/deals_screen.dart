import 'package:flutter/material.dart';

class DealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deals = [
      {'title': '25% off - Beach resorts', 'subtitle': 'Valid this weekend only'},
      {'title': 'Save on flights to Europe', 'subtitle': 'Limited seats available'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Deals')),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: deals.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, i) {
          final d = deals[i];
          return Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(d['title']!, style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 6), Text(d['subtitle']!)])),
              ElevatedButton(onPressed: () {}, child: Text('View'))
            ]),
          );
        },
      ),
    );
  }
}