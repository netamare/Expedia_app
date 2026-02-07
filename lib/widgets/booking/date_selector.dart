import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final DateTime? initialStart;
  final DateTime? initialEnd;
  final void Function(DateTime start, DateTime end)? onChanged;
  const DateSelector({this.initialStart, this.initialEnd, this.onChanged});
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? start;
  DateTime? end;
  final df = DateFormat('MMM d');

  @override
  void initState() {
    super.initState();
    start = widget.initialStart ?? DateTime.now();
    end = widget.initialEnd ?? DateTime.now().add(Duration(days: 1));
  }

  Future<void> _pickDates() async {
    final pickedStart = await showDatePicker(context: context, initialDate: start!, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
    if (pickedStart == null) return;
    final pickedEnd = await showDatePicker(context: context, initialDate: end!, firstDate: pickedStart.add(Duration(days: 1)), lastDate: DateTime.now().add(Duration(days: 366)));
    if (pickedEnd == null) return;
    setState(() {
      start = pickedStart;
      end = pickedEnd;
    });
    widget.onChanged?.call(start!, end!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickDates,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Check-in', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            SizedBox(height: 4),
            Text(df.format(start!)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('Check-out', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            SizedBox(height: 4),
            Text(df.format(end!)),
          ]),
        ]),
      ),
    );
  }
}