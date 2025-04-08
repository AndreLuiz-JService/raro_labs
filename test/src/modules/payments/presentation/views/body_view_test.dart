import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/views/body_view.dart';
import 'package:base_project/src/modules/payments/presentation/views/schedule/schedule_view.dart';
import 'package:base_project/src/modules/payments/presentation/views/transactions/transactions_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BodyView', () {
    late PaymentsState mockState;

    setUp(() {
      mockState = PaymentsLoaded(
        viewType: PaymentsViewType.schedule,
        paymentsInfo: PaymentsInfoModel.fromJson({
          'paymentsScheduled': [],
          'transactions': [],
          'transactionFilter': [],
          'summary': [],
        }),
        activeFilters: {},
      );
    });

    testWidgets('should show ScheduleView when viewType is schedule', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BodyView(
              state: mockState,
              viewType: PaymentsViewType.schedule,
            ),
          ),
        ),
      );

      expect(find.byType(ScheduleView), findsOneWidget);
    });

    testWidgets('should show TransactionsView when viewType is transactions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BodyView(
              state: mockState,
              viewType: PaymentsViewType.transactions,
            ),
          ),
        ),
      );

      expect(find.byType(TransactionsView), findsOneWidget);
    });
  });
}
