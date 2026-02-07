import 'package:flutter/material.dart';
import '../../models/hotel.dart';
import '../../constants/app_constants.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback? onTap;
  const HotelCard({required this.hotel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
              () {
            Navigator.pushNamed(context, '/hotel_detail', arguments: hotel);
          },
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
            child: Image.network(
              hotel.imageUrl,
              width: 110,
              height: 92,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  width: 110,
                  height: 92,
                  color: Colors.grey[200],
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 110,
                  height: 92,
                  color: Colors.grey[200],
                  child: Icon(Icons.broken_image, color: Colors.grey[600]),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(hotel.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text(hotel.location, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                SizedBox(height: 8),
                Row(children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  SizedBox(width: 6),
                  Text('${hotel.rating}', style: TextStyle(fontWeight: FontWeight.w600)),
                  Spacer(),
                  Text('${AppConstants.defaultCurrency}${hotel.price.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold)),
                ])
              ]),
            ),
          )
        ]),
      ),
    );
  }
}