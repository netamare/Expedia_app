import 'dart:convert';
import 'dart:async';
import '../models/flight.dart';

class FlightService {
  Future<List<Flight>> fetchFlights() async {
    await Future.delayed(Duration(milliseconds: 800));
    final jsonString = '''
    [
      {"id":1,"airline":"CloudAir","from":"SFO","to":"LAX","departureTime":"08:00","arrivalTime":"09:20","price":89,"duration":"1h 20m"},
      {"id":2,"airline":"Skyways","from":"NYC","to":"MIA","departureTime":"12:30","arrivalTime":"15:10","price":159,"duration":"2h 40m"},
      {"id":3,"airline":"JetFast","from":"SEA","to":"DEN","departureTime":"07:15","arrivalTime":"10:05","price":129,"duration":"2h 50m"}
    ]
    ''';
    final List<dynamic> parsed = json.decode(jsonString);
    return parsed.map((e) => Flight.fromJson(Map<String, dynamic>.from(e))).toList();
  }
}