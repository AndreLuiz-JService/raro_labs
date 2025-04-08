import 'package:base_project/src/modules/payments/presentation/views/shared/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorView', () {
    testWidgets('should render error message', (WidgetTester tester) async {
      const errorMessage = 'Test error message';

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ErrorView(message: errorMessage))),
      );

      expect(find.text('Error: $errorMessage'), findsOneWidget);
    });
  });
}
