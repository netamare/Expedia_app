import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expedia_app/main.dart';

void main() {
  testWidgets('Main app shows bottom navigation with Home', (WidgetTester tester) async {
    // Pump the app widget
    await tester.pumpWidget(ExpediaApp());

    // Wait for all frames to settle
    await tester.pumpAndSettle();

    // Expect to find the bottom navigation label 'Home'
    expect(find.text('Home'), findsOneWidget);

    // Also check that at least one BottomNavigationBarItem icon is present
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}