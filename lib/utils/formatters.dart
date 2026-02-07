// import 'package:intl/intl.dart';

import 'package:intl/intl.dart';

String formatCurrency(double value, {String symbol = '\$'}) {
  final f = NumberFormat.currency(symbol: symbol, decimalDigits: 0);
  return f.format(value);
}