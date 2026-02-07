import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  const RatingWidget(this.rating);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.star, color: Colors.amber, size: 16),
      SizedBox(width: 4),
      Text(rating.toString(), style: TextStyle(fontWeight: FontWeight.w600)),
    ]);
  }
}