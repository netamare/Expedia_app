import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {'title': 'Booking confirmed!', 'body': 'Your booking for Miami Beach hotel is confirmed.'},
    {'title': 'Price drop alert', 'body': 'Flights to Paris are \$50 cheaper.'},
    {'title': 'Travel notice', 'body': 'COVID-19 requirements have changed for your destination.'},
    {'title': 'Promo', 'body': 'Flash sale: Save 20% on European stays.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inbox'), centerTitle: true),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: messages.length,
        separatorBuilder: (_, __) => SizedBox(height: 14),
        itemBuilder: (context, i) => Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.notifications_active),
            title: Text(messages[i]['title']!),
            subtitle: Text(messages[i]['body']!),
          ),
        ),
      ),
    );
  }
}