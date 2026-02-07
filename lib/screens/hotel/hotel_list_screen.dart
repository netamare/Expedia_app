import 'package:flutter/material.dart';
import '../../services/hotel_service.dart';
import '../../models/hotel.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/home/featured_hotel_card.dart';

class HotelListScreen extends StatefulWidget {
  @override
  _HotelListScreenState createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  final HotelService _service = HotelService();
  bool loading = true;
  String error = '';
  List<Hotel> hotels = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = '';
    });
    try {
      hotels = await _service.fetchHotels();
    } catch (e) {
      error = 'Unable to load hotels';
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels'),
      ),
      body: loading
          ? LoadingIndicator()
          : error.isNotEmpty
          ? Center(child: Text(error))
          : ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: hotels.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final h = hotels[index];
          return FeaturedHotelCard(hotel: h);
        },
      ),
    );
  }
}