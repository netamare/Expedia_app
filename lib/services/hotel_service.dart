import '../models/hotel.dart';
import 'api_service.dart';

class HotelService {
  Future<List<Hotel>> fetchHotels() async {
    final json = await ApiService.fetchHotelsJson();
    return json.map((h) => Hotel.fromJson(h)).toList();
  }

  Future<Hotel?> getHotelById(String id) async {
    final hotels = await fetchHotels();
    try {
      return hotels.firstWhere((h) => h.id == id);
    } catch (e) {
      return null;
    }
  }
}