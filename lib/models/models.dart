class City {
  final String code;
  final String name;
  final String displayName;
  final String country;
  final String region;

  City({
    required this.code,
    required this.name,
    required this.displayName,
    required this.country,
    required this.region,
  });
}

class Flight {
  final String fromCode;
  final String toCode;
  final String airline;
  final String operator;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final int stops;
  final String stopText;
  final String price;
  final String cabin;
  final int seatsLeft;
  final String logoAsset;
  final List<FlightLeg> legs;

  Flight({
    required this.fromCode,
    required this.toCode,
    required this.airline,
    required this.operator,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.stops,
    required this.stopText,
    required this.price,
    required this.cabin,
    required this.seatsLeft,
    required this.logoAsset,
    required this.legs,
  });
}

class FlightLeg {
  final String airline;
  final String flightNumber;
  final String fromCity;
  final String toCity;
  final String fromAirport;
  final String toAirport;
  final String depTime;
  final String arrTime;
  final String travelTime;
  final String terminalFrom;
  final String terminalTo;
  final String distance;
  final String aircraft;
  final String cabin;
  final List<String> amenities;
  final String emission;

  FlightLeg({
    required this.airline,
    required this.flightNumber,
    required this.fromCity,
    required this.toCity,
    required this.fromAirport,
    required this.toAirport,
    required this.depTime,
    required this.arrTime,
    required this.travelTime,
    required this.terminalFrom,
    required this.terminalTo,
    required this.distance,
    required this.aircraft,
    required this.cabin,
    required this.amenities,
    required this.emission,
  });
}