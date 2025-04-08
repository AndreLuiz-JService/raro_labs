import 'package:base_project/src/modules/payments/presentation/views/transactions/transactions_loaded_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransactionItem', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      const title = 'Test Title';
      const value = 'Test Value';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TransactionItem(title: title, value: value)),
        ),
      );

      expect(find.text(title), findsOneWidget);
      expect(find.text(value), findsOneWidget);
    });
  });
}
