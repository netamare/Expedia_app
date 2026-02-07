class CarRental {
  final String id;
  final String company;
  final String model;
  final double pricePerDay;
  final String imageUrl;
  CarRental({
    required this.id,
    required this.company,
    required this.model,
    required this.pricePerDay,
    required this.imageUrl,
  });

  factory CarRental.fromJson(Map<String, dynamic> json) => CarRental(
    id: json['id'].toString(),
    company: json['company'] ?? '',
    model: json['model'] ?? '',
    pricePerDay: (json['pricePerDay'] ?? 0).toDouble(),
    imageUrl: json['imageUrl'] ?? '',
  );
}