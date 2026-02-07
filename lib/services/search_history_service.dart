import 'dart:collection';

class SearchEntry {
  final String type; // 'flight' or 'stay' or 'car'
  final String query; // e.g. "ADD → LAX" or "Miami Beach"
  final DateTime timestamp;

  SearchEntry({required this.type, required this.query}) : timestamp = DateTime.now();
}

class SearchHistoryService {
  final List<SearchEntry> _items = [];

  // limit to last N entries
  final int maxEntries;
  SearchHistoryService({this.maxEntries = 20});

  UnmodifiableListView<SearchEntry> get recent =>
      UnmodifiableListView(_items.reversed.toList());

  void add(SearchEntry e) {
    // dedupe similar recent entry
    _items.removeWhere((x) => x.query == e.query && x.type == e.type);
    _items.add(e);
    if (_items.length > maxEntries) _items.removeRange(0, _items.length - maxEntries);
  }

  void clear() => _items.clear();
}