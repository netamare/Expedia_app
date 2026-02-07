String prettyDateRange(DateTime start, DateTime end) {
  final startStr = "${start.month}/${start.day}/${start.year}";
  final endStr = "${end.month}/${end.day}/${end.year}";
  return "$startStr - $endStr";
}