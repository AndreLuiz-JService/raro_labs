import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/summary_cards.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/skeleton_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SummaryCards', () {
    late PaymentsState mockState;

    setUp(() {
      mockState = PaymentsLoaded(
        viewType: PaymentsViewType.schedule,
        paymentsInfo: PaymentsInfoModel.fromJson({
          'paymentsScheduled': [
            {
              'key': '1',
              'paymentDate': '2024-01-01',
              'interest': 100.0,
              'principal': 200.0,
              'total': 300.0,
            },
          ],
          'transactions': [],
          'transactionFilter': [
            {
              "key": "actualPaymentAmount",
              "label": "Amount",
              "isDefault": true,
            },
            {
              "key": "actualPrincipalPaymentAmount",
              "label": "Principal",
              "isDefault": true,
            },
            {
              "key": "actualInterestPaymentAmount",
              "label": "Interest",
              "isDefault": true,
            },
          ],
          'summary': [
            {'key': 'actualPaymentAmount', 'label': 'Amount', 'value': 1000.0},
            {
              'key': 'actualPrincipalPaymentAmount',
              'label': 'Principal',
              'value': 500.0,
            },
            {
              'key': 'actualInterestPaymentAmount',
              'label': 'Interest',
              'value': 300.0,
            },
          ],
        }),
        activeFilters: {},
      );
    });

    testWidgets('should render correctly in loading state', (
      WidgetTester tester,
    ) async {
      final loadingState = PaymentsLoading(viewType: PaymentsViewType.schedule);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200,
              width: 600,
              child: SummaryCards(state: loadingState),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(SkeletonWithTitle), findsWidgets);

      expect(find.text('Outstanding'), findsOneWidget);
      expect(find.text('Total Paid'), findsOneWidget);
      expect(find.text('Principal Paid'), findsOneWidget);
      expect(find.text('Interest Paid'), findsOneWidget);
    });

    testWidgets('should render cards in loaded state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200,
              width: 800,
              child: SummaryCards(state: mockState),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Principal'), findsOneWidget);
      expect(find.text('Interest'), findsOneWidget);
    });

    testWidgets('should show correct values in cards', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200,
              width: 800,
              child: SummaryCards(state: mockState),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('\$1000'), findsOneWidget);
      expect(find.text('\$500'), findsOneWidget);
      expect(find.text('\$300'), findsOneWidget);
    });

    testWidgets('should not render anything when there is no data', (
      WidgetTester tester,
    ) async {
      final emptyState = PaymentsLoaded(
        viewType: PaymentsViewType.schedule,
        paymentsInfo: PaymentsInfoModel.fromJson({
          'paymentsScheduled': [],
          'transactions': [],
          'transactionFilter': [],
          'summary': [
            {'key': 'actualPaymentAmount', 'label': 'Amount', 'value': 1000.0},
          ],
        }),
        activeFilters: {},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 200,
              width: 800,
              child: SummaryCards(state: emptyState),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Amount'), findsNothing);
    });
  });
}
