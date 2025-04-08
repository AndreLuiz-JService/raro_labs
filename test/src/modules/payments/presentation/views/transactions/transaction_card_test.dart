import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/views/transactions/transactions_loaded_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransactionCard', () {
    late PaymentsTransactionsEntity mockTransaction;
    late Map<String, bool> mockActiveFilters;

    setUp(() {
      mockTransaction = PaymentsTransactionsModel.fromJson({
        'key': '1',
        'actualPaymentPostDate': '2024-01-01T00:00:00',
        'processDate': '2024-01-01T00:00:00',
        'summary': 'Test transaction',
        'actualPaymentAmount': 100.0,
        'actualPrincipalPaymentAmount': 80.0,
        'actualInterestPaymentAmount': 20.0,
        'outstandingPrincipalBalance': 900.0,
        'outstandingLoanBalance': 920.0,
        'actualFee': 0.0,
        'paymentType': 'Regular Payment',
        'type': 1,
      });
      mockActiveFilters = {'Process Date': true, 'Amount': true, 'Type': true};
    });

    testWidgets('should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionCard(
              transaction: mockTransaction,
              activeFilters: mockActiveFilters,
            ),
          ),
        ),
      );

      expect(find.byType(TransactionCard), findsOneWidget);
    });

    testWidgets('should show correct number of transaction items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionCard(
              transaction: mockTransaction,
              activeFilters: mockActiveFilters,
            ),
          ),
        ),
      );

      expect(find.byType(TransactionItem), findsNWidgets(3));
    });

    testWidgets('should show only active filter values', (
      WidgetTester tester,
    ) async {
      final partialFilters = {
        'Process Date': true,
        'Amount': false,
        'Type': true,
      };

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TransactionCard(
              transaction: mockTransaction,
              activeFilters: partialFilters,
            ),
          ),
        ),
      );

      expect(find.text('Process Date'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Type'), findsOneWidget);

      expect(find.text('Regular Payment'), findsOneWidget);

      final amountValueTexts =
          tester.allWidgets
              .whereType<Text>()
              .where((widget) => widget.data == '')
              .toList();

      expect(amountValueTexts.length, greaterThanOrEqualTo(1));
    });
  });
}
