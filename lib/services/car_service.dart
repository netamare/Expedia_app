// Simple fake car service for demo purposes.
// Place this file at lib/services/car_service.dart

import 'dart:async';
import '../models/car_rental.dart';

class CarService {
  Future<List<CarRental>> fetchCars() async {
    await Future.delayed(Duration(milliseconds: 700));
    final cars = [
      {
        'id': 1,
        'company': 'RentQuick',
        'model': 'Toyota Corolla',
        'pricePerDay': 45,
        'imageUrl': 'https://images.unsplash.com/photo-1542362567-b07e54358753?w=800&q=80'
      },
      {
        'id': 2,
        'company': 'AutoGo',
        'model': 'Ford Mustang',
        'pricePerDay': 120,
        'imageUrl': 'https://images.unsplash.com/photo-1502877338535-766e1452684a?w=800&q=80'
      },
      {
        'id': 3,
        'company': 'CityCars',
        'model': 'Volkswagen Golf',
        'pricePerDay': 55,
        'imageUrl': 'https://images.unsplash.com/photo-1511914265874-0c3b4b8a137c?w=800&q=80'
      },
    ];
    return cars.map((c) => CarRental.fromJson(Map<String, dynamic>.from(c))).toList();
  }
}