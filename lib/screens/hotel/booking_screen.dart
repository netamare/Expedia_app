import 'package:flutter/material.dart';
import '../../models/hotel.dart';
import '../../widgets/booking/date_selector.dart';
import '../../widgets/booking/guest_selector.dart';
import '../../widgets/booking/price_summary.dart';
import '../../widgets/hotel/room_card.dart';
import '../../utils/price_calculator.dart';

class BookingScreen extends StatefulWidget {
  // Expect Hotel passed in arguments when navigating:
  // Navigator.pushNamed(context, '/booking', arguments: hotel);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Hotel? hotel;
  DateTime checkIn = DateTime.now();
  DateTime checkOut = DateTime.now().add(Duration(days: 1));
  int guests = 2;
  int nights = 1;
  double taxRate = 0.12; // 12% fake taxes
  double roomPrice = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Hotel) {
      hotel = args;
      roomPrice = hotel!.price;
    }
  }

  void _onDatesChanged(DateTime start, DateTime end) {
    setState(() {
      checkIn = start;
      checkOut = end;
      nights = end.difference(start).inDays;
      if (nights < 1) nights = 1;
    });
  }

  void _onGuestsChanged(int g) {
    setState(() {
      guests = g;
    });
  }

  void _onSelectRoom(double price) {
    setState(() {
      roomPrice = price;
    });
  }

  void _book() {
    final total = calculateTotal(roomPrice, nights, taxRate);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booked ${hotel?.name} — Total: \$${total.toStringAsFixed(2)}')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (hotel == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Booking')),
        body: Center(child: Text('No hotel selected')),
      );
    }

    final subtotal = roomPrice * nights;
    final taxes = subtotal * taxRate;
    final total = calculateTotal(roomPrice, nights, taxRate);

    final availableRooms = [
      {'title': 'Standard Room', 'subtitle': '1 queen bed • Free wifi', 'price': hotel!.price},
      {'title': 'Deluxe Room', 'subtitle': '1 king bed • Ocean view', 'price': hotel!.price + 40},
      {'title': 'Suite', 'subtitle': '2 beds • Living area', 'price': hotel!.price + 90},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Book — ${hotel!.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          DateSelector(
            initialStart: checkIn,
            initialEnd: checkOut,
            onChanged: _onDatesChanged,
          ),
          SizedBox(height: 12),
          GuestSelector(initialGuests: guests, onChanged: _onGuestsChanged),
          SizedBox(height: 16),
          Text('Choose a room', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: availableRooms.length,
              separatorBuilder: (_, __) => SizedBox(height: 8),
              itemBuilder: (context, i) {
                final r = availableRooms[i];
                return RoomCard(
                  title: r['title'] as String,
                  subtitle: r['subtitle'] as String,
                  price: (r['price'] as num).toDouble(),
                );
              },
            ),
          ),
          PriceSummary(subtotal: subtotal, taxes: taxes, total: total),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: _book,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Confirm and pay — \$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
          )
        ]),
      ),
    );
  }
}