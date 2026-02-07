import 'dart:convert';
import 'dart:async';

class ApiService {
  // Simulated backend response; in real app replace with http calls.
  static Future<List<Map<String, dynamic>>> fetchHotelsJson() async {
    await Future.delayed(Duration(milliseconds: 800)); // simulate latency
    final jsonString = '''
    [
      {
        "id": 1,
        "name": "Seaside Resort",
        "location": "Miami Beach, FL",
        "imageUrl": "https://images.unsplash.com/photo-1496412705862-e0088f16f791?w=800&q=80",
        "rating": 4.6,
        "price": 199,
        "description": "Oceanfront rooms with modern amenities and great service."
      },
      {
        "id": 2,
        "name": "Mountain Lodge",
        "location": "Aspen, CO",
        "imageUrl": "https://images.unsplash.com/photo-1496412705862-e0088f16f791?w=800&q=80",
        "rating": 4.7,
        "price": 249,
        "description": "Cozy lodge near top ski runs and beautiful trails."
      },
      {
        "id": 3,
        "name": "City Lights Hotel",
        "location": "New York, NY",
        "imageUrl": "https://images.unsplash.com/photo-1496412705862-e0088f16f791?w=800&q=80",
        "rating": 4.4,
        "price": 179,
        "description": "In the heart of the city, near major attractions and nightlife."
      },
      {
        "id": 4,
        "name": "Desert Oasis",
        "location": "Phoenix, AZ",
        "imageUrl": "https://images.unsplash.com/photo-1496412705862-e0088f16f791?w=800&q=80",
        "rating": 4.2,
        "price": 129,
        "description": "Comfortable rooms with a relaxing pool and spa."
      }
    ]
    ''';
    final List<dynamic> parsed = json.decode(jsonString);
    return parsed.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}