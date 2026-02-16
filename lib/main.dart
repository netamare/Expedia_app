import 'package:flutter/material.dart';
import 'flight_booking_main_page.dart';

void main() => runApp(ExpediaFlightBookingDemo());

class ExpediaFlightBookingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expedia Flight Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans-serif',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Color(0xFF266CFF)),
      ),
      home: FlightBookingMainPage(),
    );
  }
}