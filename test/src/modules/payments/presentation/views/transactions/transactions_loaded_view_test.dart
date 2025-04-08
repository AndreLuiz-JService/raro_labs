import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/views/transactions/transactions_loaded_view.dart';
import 'package:base_project/src/modules/payments/data/model/payments/payments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransactionsLoadedView', () {
    late PaymentsLoaded mockState;

    setUp(() {
      mockState = PaymentsLoaded(
        viewType: PaymentsViewType.transactions,
        paymentsInfo: PaymentsInfoModel.fromJson({
          'paymentsScheduled': [],
          'transactions': [
            {
              'key': '1',
              'actualPaymentPostDate': '2024-01-01T00:00:00',
              'processDate': '2024-01-01T00:00:00',
              'actualPaymentAmount': 100.0,
              'actualPrincipalPaymentAmount': 50.0,
              'actualInterestPaymentAmount': 50.0,
              'outstandingPrincipalBalance': 1000.0,
              'outstandingLoanBalance': 1000.0,
              'actualFee': 0.0,
              'paymentType': 'Regular',
              'type': 1,
            },
          ],
          'transactionFilters': [],
          'summary': [],
        }),
        activeFilters: {'Process Date': true, 'Amount': true},
      );
    });

    testWidgets('should show empty state when no transactions', (
      WidgetTester tester,
    ) async {
      final emptyState = PaymentsLoaded(
        viewType: PaymentsViewType.transactions,
        paymentsInfo: PaymentsInfoModel.empty(),
        activeFilters: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TransactionsLoadedView(state: emptyState)),
        ),
      );

      // Verificar se o EmptyTransactionsView é exibido
      expect(find.byType(EmptyTransactionsView), findsOneWidget);

      // Verificar partes do texto que podem ser encontradas
      expect(
        find.textContaining('Once you begin your payments'),
        findsOneWidget,
      );

      expect(find.textContaining('1-2 business days'), findsOneWidget);
    });

    testWidgets('should show transaction cards when transactions exist', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TransactionsLoadedView(state: mockState)),
        ),
      );

      expect(find.byType(TransactionCard), findsOneWidget);
    });

    testWidgets(
      'should show correct number of transaction items based on active filters',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: TransactionsLoadedView(state: mockState)),
          ),
        );

        expect(find.byType(TransactionItem), findsNWidgets(2));
      },
    );
  });
}
