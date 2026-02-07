import 'package:flutter/material.dart';

class PassengerData {
  final int adults;
  final int children;
  final int infants;
  final String label;

  // make this a const constructor so it can be used as a default value
  const PassengerData({
    required this.adults,
    required this.children,
    required this.infants,
  }) : label =
  '${adults + children} passenger${(adults + children) > 1 ? 's' : ''}, $infants infant${infants != 1 ? 's' : ''}';
}

class PassengerSelector extends StatefulWidget {
  final PassengerData initial;
  final void Function(PassengerData)? onChanged;

  const PassengerSelector({
    Key? key,
    this.initial = const PassengerData(adults: 1, children: 0, infants: 0),
    this.onChanged,
  }) : super(key: key);

  @override
  _PassengerSelectorState createState() => _PassengerSelectorState();
}

class _PassengerSelectorState extends State<PassengerSelector> {
  late int adults;
  late int children;
  late int infants;

  @override
  void initState() {
    super.initState();
    adults = widget.initial.adults;
    children = widget.initial.children;
    infants = widget.initial.infants;
  }

  void _notify() {
    widget.onChanged?.call(PassengerData(adults: adults, children: children, infants: infants));
  }

  Widget _counter(String label, int value, ValueChanged<int> onChange) {
    return Row(children: [
      Expanded(child: Text(label)),
      IconButton(onPressed: value > 0 ? () => onChange(value - 1) : null, icon: Icon(Icons.remove_circle_outline)),
      Text('$value'),
      IconButton(onPressed: () => onChange(value + 1), icon: Icon(Icons.add_circle_outline)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      _counter('Adults', adults, (v) => setState(() {
        adults = v;
        _notify();
      })),
      _counter('Children', children, (v) => setState(() {
        children = v;
        _notify();
      })),
      _counter('Infants', infants, (v) => setState(() {
        infants = v;
        _notify();
      })),
    ]);
  }
}