import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/views/schedule/schedule_loaded_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScheduleLoadedView', () {
    late PaymentsLoaded mockEmptyState;
    late PaymentsLoaded mockStateWithPayments;

    setUp(() {
      // Estado vazio
      mockEmptyState = PaymentsLoaded(
        viewType: PaymentsViewType.schedule,
        paymentsInfo: PaymentsInfoModel.fromJson({
          'paymentsScheduled': [],
          'transactions': [],
          'transactionFilter': [],
          'summary': [],
        }),
        activeFilters: {'Date': true, 'Amount': true, 'Type': true},
      );

      // Estado com pagamentos agendados
      mockStateWithPayments = PaymentsLoaded(
        viewType: PaymentsViewType.schedule,
        paymentsInfo: PaymentsInfoModel.fromJson({
          'paymentsScheduled': [
            {
              'paymentDate': '2024-01-01T00:00:00',
              'interest': 100.0,
              'principal': 0.0,
              'total': 100.0,
              'outstandingBalance': 0.0,
              'pastDue': false,
              'status': 'ok',
              'paymentType': 'PaymentType1',
            },
          ],
          'transactions': [],
          'transactionFilter': [],
          'summary': [],
        }),
        activeFilters: {'Date': true, 'Amount': true, 'Type': true},
      );
    });

    testWidgets('should show empty state when no scheduled payments', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ScheduleLoadedView(state: mockEmptyState)),
        ),
      );

      // Verificar se o EmptyScheduleView é exibido
      expect(find.byType(EmptyScheduleView), findsOneWidget);

      // Verificar partes do texto que podem ser encontradas
      expect(find.textContaining('Once your loan is booked'), findsOneWidget);

      expect(find.textContaining('1-2 business days'), findsOneWidget);
    });

    testWidgets('should show schedule items when payments exist', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScheduleLoadedView(state: mockStateWithPayments),
          ),
        ),
      );

      expect(find.byType(ScheduleItem), findsOneWidget);
    });

    testWidgets('should show next payment indicator on first item', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScheduleLoadedView(state: mockStateWithPayments),
          ),
        ),
      );

      expect(find.text('Next'), findsOneWidget);
    });
  });
}
