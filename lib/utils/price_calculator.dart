double calculateTotal(double basePrice, int nights, double taxRate) {
  final subtotal = basePrice * nights;
  final taxes = subtotal * taxRate;
  return subtotal + taxes;
}