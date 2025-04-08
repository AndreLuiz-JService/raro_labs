import 'package:base_project/src/modules/payments/presentation/views/transactions/transactions_loading_view.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/scroll_indicator_place_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransactionsLoadingView', () {
    testWidgets('should render loading skeleton items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: const TransactionsLoadingView())),
      );

      expect(find.byType(SkeletonItem), findsNWidgets(2));
      expect(find.byType(ScrollIndicatorPlaceholder), findsOneWidget);
    });
  });
}
