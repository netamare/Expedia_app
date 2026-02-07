import 'dart:async';

class PriceAlert {
  final String id;
  final String type; // 'flight' or 'stay'
  final String query;
  final double targetPrice;
  final DateTime createdAt;

  PriceAlert({
    required this.id,
    required this.type,
    required this.query,
    required this.targetPrice,
  }) : createdAt = DateTime.now();
}

class PriceAlertService {
  final List<PriceAlert> _alerts = [];

  List<PriceAlert> get alerts => List.unmodifiable(_alerts);

  void createAlert(PriceAlert a) {
    _alerts.add(a);
  }

  // Fake trigger; in a real app you'd poll an API or use push notifications
  Stream<PriceAlert> simulatePriceDrops(Duration every) async* {
    while (true) {
      await Future.delayed(every);
      if (_alerts.isNotEmpty) {
        // emit the first alert as "triggered" (demo)
        yield _alerts.first;
      }
    }
  }
}