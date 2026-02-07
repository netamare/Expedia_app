import 'package:flutter/material.dart';
import '../../services/search_history_service.dart';

class RecentSearchesWidget extends StatelessWidget {
  final List<SearchEntry> entries;
  final void Function(SearchEntry)? onTap;
  const RecentSearchesWidget({Key? key, required this.entries, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return SizedBox.shrink();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Recent searches', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: entries
            .take(8)
            .map((e) => ActionChip(label: Text(e.query), onPressed: () => onTap?.call(e)))
            .toList(),
      ),
    ]);
  }
}