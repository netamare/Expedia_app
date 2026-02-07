class Destination {
  final String id;
  final String name;
  final String country;
  final String imageUrl;
  Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    id: json['id'].toString(),
    name: json['name'] ?? '',
    country: json['country'] ?? '',
    imageUrl: json['imageUrl'] ?? '',
  );
}