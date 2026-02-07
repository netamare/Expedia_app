import 'package:flutter/material.dart';

enum CabinClass { economy, premiumEconomy, business, first }

extension CabinClassLabel on CabinClass {
  String get label {
    switch (this) {
      case CabinClass.economy:
        return 'Economy';
      case CabinClass.premiumEconomy:
        return 'Premium Economy';
      case CabinClass.business:
        return 'Business';
      case CabinClass.first:
        return 'First';
    }
  }
}

class CabinSelector extends StatelessWidget {
  final CabinClass value;
  final ValueChanged<CabinClass> onChanged;
  const CabinSelector({Key? key, required this.value, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<CabinClass>(
      value: value,
      items: CabinClass.values
          .map((c) => DropdownMenuItem(child: Text(c.label), value: c))
          .toList(),
      // DropdownButton onChanged provides CabinClass? so accept nullable and forward non-null to callback
      onChanged: (CabinClass? c) {
        if (c != null) onChanged(c);
      },
    );
  }
}