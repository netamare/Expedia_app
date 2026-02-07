import 'package:flutter/material.dart';
import '../../models/hotel.dart';
import '../../constants/app_constants.dart';

class FeaturedHotelCard extends StatelessWidget {
  final Hotel hotel;
  final bool compact;
  const FeaturedHotelCard({required this.hotel, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: compact ? double.infinity : 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          Expanded(
            flex: compact ? 0 : 4,
            child: GestureDetector(
              onTap: () => _openDetail(context),
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
                child: Image.network(
                  hotel.imageUrl,
                  height: compact ? 96 : 200,
                  width: compact ? 120 : 160,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      width: compact ? 120 : 160,
                      height: compact ? 96 : 200,
                      color: Colors.grey[200],
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: compact ? 120 : 160,
                      height: compact ? 96 : 200,
                      color: Colors.grey[200],
                      child: Icon(Icons.broken_image_outlined, color: Colors.grey[600], size: 28),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hotel.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text(hotel.location, style: TextStyle(color: Colors.grey[700])),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 6),
                      Text('${hotel.rating}'),
                      Spacer(),
                      Text('${AppConstants.defaultCurrency}${hotel.price.toStringAsFixed(0)}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

    if (compact) {
      return card;
    }

    return GestureDetector(onTap: () => _openDetail(context), child: card);
  }

  void _openDetail(BuildContext context) {
    Navigator.pushNamed(context, '/hotel_detail', arguments: hotel);
  }
}