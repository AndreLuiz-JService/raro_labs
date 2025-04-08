import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/tab_bar.dart';
import 'package:base_project/src/modules/payments/data/model/payments/payments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TabBarWidget', () {
    late PaymentsState mockState;
    late Function(PaymentsViewType) onViewTypeChanged;
    late Function(Map<String, bool>) onFiltersChanged;

    setUp(() {
      mockState = PaymentsLoaded(
        viewType: PaymentsViewType.schedule,
        paymentsInfo: PaymentsInfoModel.empty(),
        activeFilters: {},
      );
      onViewTypeChanged = (viewType) {};
      onFiltersChanged = (filters) {};
    });

    testWidgets('should render correctly with schedule view', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TabBarWidget(
              currentViewType: PaymentsViewType.schedule,
              state: mockState,
              onViewTypeChanged: onViewTypeChanged,
              onFiltersChanged: onFiltersChanged,
              firstTabTitle: 'SCHEDULE',
              secondTabTitle: 'TRANSACTIONS',
            ),
          ),
        ),
      );

      expect(find.text('SCHEDULE'), findsOneWidget);
      expect(find.text('TRANSACTIONS'), findsOneWidget);
      expect(find.byType(IconButton), findsNothing);
    });

    testWidgets('should render correctly with transactions view and no data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TabBarWidget(
              currentViewType: PaymentsViewType.transactions,
              state: mockState,
              onViewTypeChanged: onViewTypeChanged,
              onFiltersChanged: onFiltersChanged,
              firstTabTitle: 'SCHEDULE',
              secondTabTitle: 'TRANSACTIONS',
            ),
          ),
        ),
      );

      expect(find.text('SCHEDULE'), findsOneWidget);
      expect(find.text('TRANSACTIONS'), findsOneWidget);
      expect(find.byType(IconButton), findsNothing);
    });

    testWidgets('should render correctly with transactions view and data', (
      WidgetTester tester,
    ) async {
      final stateWithData = PaymentsLoaded(
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
        activeFilters: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TabBarWidget(
              currentViewType: PaymentsViewType.transactions,
              state: stateWithData,
              onViewTypeChanged: onViewTypeChanged,
              onFiltersChanged: onFiltersChanged,
              firstTabTitle: 'SCHEDULE',
              secondTabTitle: 'TRANSACTIONS',
            ),
          ),
        ),
      );

      expect(find.text('SCHEDULE'), findsOneWidget);
      expect(find.text('TRANSACTIONS'), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('should call onViewTypeChanged when tab is tapped', (
      WidgetTester tester,
    ) async {
      var viewTypeChanged = false;
      onViewTypeChanged = (viewType) {
        viewTypeChanged = true;
      };

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TabBarWidget(
              currentViewType: PaymentsViewType.schedule,
              state: mockState,
              onViewTypeChanged: onViewTypeChanged,
              onFiltersChanged: onFiltersChanged,
              firstTabTitle: 'SCHEDULE',
              secondTabTitle: 'TRANSACTIONS',
            ),
          ),
        ),
      );

      await tester.tap(find.text('TRANSACTIONS'));
      await tester.pumpAndSettle();

      expect(viewTypeChanged, true);
    });
  });
}
