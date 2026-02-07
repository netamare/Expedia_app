import 'package:flutter/material.dart';

class PriceSummary extends StatelessWidget {
  final double subtotal;
  final double taxes;
  final double total;
  const PriceSummary({required this.subtotal, required this.taxes, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Subtotal'), Text('\$${subtotal.toStringAsFixed(2)}')]),
          SizedBox(height: 6),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Taxes & fees'), Text('\$${taxes.toStringAsFixed(2)}')]),
          Divider(height: 18),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Total', style: TextStyle(fontWeight: FontWeight.bold)), Text('\$${total.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold))]),
        ]),
      ),
    );
  }
}