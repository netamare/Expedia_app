import 'package:flutter/material.dart';

class GuestSelector extends StatefulWidget {
  final int initialGuests;
  final void Function(int)? onChanged;
  const GuestSelector({this.initialGuests = 2, this.onChanged});
  @override
  _GuestSelectorState createState() => _GuestSelectorState();
}

class _GuestSelectorState extends State<GuestSelector> {
  late int guests;
  @override
  void initState() {
    super.initState();
    guests = widget.initialGuests;
  }

  void _change(int delta) {
    setState(() {
      guests = (guests + delta).clamp(1, 10);
    });
    widget.onChanged?.call(guests);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Guests'),
        Row(children: [
          IconButton(onPressed: () => _change(-1), icon: Icon(Icons.remove_circle_outline)),
          Text('$guests'),
          IconButton(onPressed: () => _change(1), icon: Icon(Icons.add_circle_outline)),
        ])
      ]),
    );
  }
}