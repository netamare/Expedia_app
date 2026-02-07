import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double height;
  const LogoWidget({this.height = 36});

  @override
  Widget build(BuildContext context) {
    // simple fallback logo; avoids loading an asset that might not exist
    return Row(
      children: [
        Container(
          width: height,
          height: height,
          decoration: BoxDecoration(color: Colors.yellow[700], borderRadius: BorderRadius.circular(6)),
          child: Icon(Icons.north_east, color: Colors.black, size: height * 0.55),
        ),
        SizedBox(width: 8),
        Text('Expedia', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ],
    );
  }
}