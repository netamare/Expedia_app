import 'package:flutter/material.dart';
import '../../models/hotel.dart';
import '../../services/hotel_service.dart';

class HomeViewModel extends ChangeNotifier {
  final HotelService _hotelService;

  HomeViewModel(this._hotelService) {
    load();
  }

  bool loading = false;
  String error = '';
  List<Hotel> featured = [];
  List<Hotel> popular = [];

  Future<void> load() async {
    loading = true;
    error = '';
    notifyListeners();
    try {
      final hotels = await _hotelService.fetchHotels();
      if (hotels.isNotEmpty) {
        featured = hotels.take(3).toList();
        popular = hotels;
      }
    } catch (e) {
      error = 'Failed to load hotels';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}