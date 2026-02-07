class Flight {
  final String id;
  final String airline;
  final String from;
  final String to;
  final String departureTime;
  final String arrivalTime;
  final double price;
  final String duration;

  Flight({
    required this.id,
    required this.airline,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.duration,
  });

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
    id: json['id'].toString(),
    airline: json['airline'] ?? '',
    from: json['from'] ?? '',
    to: json['to'] ?? '',
    departureTime: json['departureTime'] ?? '',
    arrivalTime: json['arrivalTime'] ?? '',
    price: (json['price'] ?? 0).toDouble(),
    duration: json['duration'] ?? '',
  );
}